class UpdateOrders < ActiveRecord::Migration[6.1]
  def change
    remove_reference :orders, :user
    add_reference :orders, :user, foreign_key: { on_delete: :cascade }, index: true
  end
end
