class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  validates :name, :price, :description, presence: true
end
