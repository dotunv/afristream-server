class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  # Roles
  enum :role, { fan: 0, creator: 1, admin: 2 }

  # Associations
  has_many :contents, foreign_key: :creator_id, dependent: :nullify
  has_many :transactions, dependent: :destroy

  # Phone validations (optional but if present must be valid). We store normalized E.164 in phone_e164
  validates :phone_e164, uniqueness: true, allow_nil: true
  validate :email_or_phone_present

  before_validation :normalize_phone_number

  private

  def email_or_phone_present
    if (email.blank? || !email.match?(Devise.email_regexp)) && phone_e164.blank?
      errors.add(:base, "Either a valid email or a valid phone number is required")
    end
  end

  def normalize_phone_number
    return if phone_number.blank?
    parsed = Phonelib.parse(phone_number, phone_country.presence)
    if parsed.valid?
      self.phone_e164 = parsed.e164
    else
      errors.add(:phone_number, "is invalid")
    end
  end

  # Allow phone-only accounts by relaxing Devise's email requirement when phone exists
  def email_required?
    phone_e164.blank?
  end
end
