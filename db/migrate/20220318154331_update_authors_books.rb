class UpdateAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    remove_reference :authors_books, :author
    remove_reference :authors_books, :book
    add_reference :authors_books, :author, foreign_key: { on_delete: :cascade }, index: true
    add_reference :authors_books, :book, foreign_key: { on_delete: :cascade }, index: true
  end
end