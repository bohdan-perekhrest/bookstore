class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.decimal :subtotal, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.string :status
      t.timestamps
    end
    add_reference :orders, :user, foreign_key: { on_delete: :cascade }, index: true
  end
end
