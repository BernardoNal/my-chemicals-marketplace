class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :content
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
