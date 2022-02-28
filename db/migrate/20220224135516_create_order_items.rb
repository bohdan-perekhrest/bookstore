class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :book, foreign_key: true
      t.references :order, foreign_key: true
      t.integer :quantity
      t.decimal :total_price, precision: 8, scale: 2
      t.timestamps
    end
  end
end
