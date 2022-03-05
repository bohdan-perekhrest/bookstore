class RemoveColumnFromBook < ActiveRecord::Migration[6.1]
  def change
    remove_column :books, :image_data
  end
end
