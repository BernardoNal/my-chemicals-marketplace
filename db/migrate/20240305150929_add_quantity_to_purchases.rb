class AddQuantityToPurchases < ActiveRecord::Migration[7.1]
  def change
    add_column :purchases, :quantity, :integer, default: 1
  end
end
