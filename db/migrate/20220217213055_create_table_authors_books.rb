# frozen_string_literal: true

class CreateTableAuthorsBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :authors_books do |t|
      t.belongs_to :author, index: true, foreign_key: { on_delete: :cascade }
      t.belongs_to :book, index: true, foreign_key: { on_delete: :cascade }
    end
  end
end
