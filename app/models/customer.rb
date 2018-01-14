class Customer < ApplicationRecord
  has_many :orders, dependent: :delete_all

  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :city, presence: true, length: { maximum: 30 }
  validates :postcode, presence: true, length: { maximum: 30 }
  validates :street_address, presence: true, length: { maximum: 60 }
end
