class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :product

  validates :customer, presence: true
  validates :product, presence: true
  validates_date :deadline, on_or_after: -> { Date.current }

  attribute :done, :boolean, default: -> { false }
end
