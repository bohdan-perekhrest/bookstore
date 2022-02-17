# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.float :price
      t.timestamps
    end
    add_reference :books, :author_id, index: true, foreign_key: true
    add_reference :books, :category_id, index: true, foreign_key: true
  end
end
