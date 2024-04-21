class CreateStockDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :stock_details do |t|
      t.string :transaction_type
      t.integer :quantity
      t.integer :amount
      t.date :transaction_date
      t.references :stock, null: false, foreign_key: true

      t.timestamps
    end
  end
end
