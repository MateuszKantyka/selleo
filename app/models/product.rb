class Product < ApplicationRecord
  has_many :orders, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 50 },
                   uniqueness: { case_sensitive: false }
end
