class AddColumnToOrder2 < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :status, :string
    add_reference :orders, :user, foreign_key: true, index: true
  end
end
