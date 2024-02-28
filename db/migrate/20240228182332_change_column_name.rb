class ChangeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :address_name, :address
  end
end
