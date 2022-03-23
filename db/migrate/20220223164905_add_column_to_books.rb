class AddColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :published_at, :integer
  end
end
