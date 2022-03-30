# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :name
      t.float :price
      t.text :description
      t.string :image_data
      t.float :height
      t.float :width
      t.float :depth
      t.string :materials
      t.integer :published_at
      t.timestamps
    end
    add_reference :books, :category, foreign_key: { on_delete: :cascade}, index: true
  end
end
