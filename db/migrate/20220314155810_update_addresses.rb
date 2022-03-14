class UpdateAddresses < ActiveRecord::Migration[6.1]
  def change
    remove_reference :addresses, :user
    remove_reference :addresses, :order
    add_reference :addresses, :user, foreign_key: { on_delete: :cascade}, index: true
    add_reference :addresses, :order, foreign_key: { on_delete: :cascade }, index: true
  end
end
