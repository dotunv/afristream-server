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
end
