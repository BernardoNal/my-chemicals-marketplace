class Purchase < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates :date_purchase, presence: true
end
