class AddColumnToAuthors < ActiveRecord::Migration[6.1]
  def change
    add_column :authors, :description, :text
  end
end
