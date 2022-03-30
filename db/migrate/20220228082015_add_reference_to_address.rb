class AddColumnToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :order, foreign_key: { on_delete: :cascade }, index: true
  end
end
