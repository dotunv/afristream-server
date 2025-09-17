class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :content

  enum :status, { pending: 0, success: 1, failed: 2 }

  validates :amount_cents, numericality: { greater_than_or_equal_to: 0 }
end
