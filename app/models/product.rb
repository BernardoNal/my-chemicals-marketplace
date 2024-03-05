class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :cart_items
  has_many :reviews, dependent: :destroy
  has_many :carts, through: :cart_items
  has_one_attached :photo
  validates :name, :price, :description, :photo, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
