class UpdateBooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :books, :category
    add_reference :books, :category, foreign_key: { on_delete: :cascade}, index: true
  end
end