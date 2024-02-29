class Product < ApplicationRecord
  belongs_to :user
  has_many :purchases
  has_one_attached :photo
  validates :name, :price, :description, presence: true
end
