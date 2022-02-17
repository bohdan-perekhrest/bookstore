# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.float :price
      t.text :short_description
      t.text :full_description
      t.string :image_data
      t.timestamps
    end
    add_reference :books, :category, index: true, foreign_key: true
  end
end
