class Content < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_one_attached :file
  has_one_attached :original_subtitle
  has_many_attached :translated_subtitles

  has_many :transactions, dependent: :destroy
  has_many :royalties, dependent: :destroy

  # price stored as integer cents
  validates :price_cents, numericality: { greater_than_or_equal_to: 0 }
end
