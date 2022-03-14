class UpdateOrderItems < ActiveRecord::Migration[6.1]
  def change
    remove_reference :order_items, :book
    remove_reference :order_items, :order
    add_reference :order_items, :book, foreign_key: { on_delete: :cascade}, index: true
    add_reference :order_items, :order, foreign_key: { on_delete: :cascade }, index: true
  end
end
