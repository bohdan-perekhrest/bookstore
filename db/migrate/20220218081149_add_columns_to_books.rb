# frozen_string_literal: true

class AddColumnsToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :height, :float
    add_column :books, :width, :float
    add_column :books, :depth, :float
    add_column :books, :materials, :string
    remove_column :books, :short_description
    rename_column :books, :full_description, :description
  end
end
