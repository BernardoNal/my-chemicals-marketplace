class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_many :reviews
  has_one_attached :photo
  validates :name, :price, :description, :photo, presence: true
end
