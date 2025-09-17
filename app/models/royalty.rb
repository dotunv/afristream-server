class Royalty < ApplicationRecord
  belongs_to :content
  belongs_to :creator, class_name: 'User'

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end
