class AddColumnToReview2 < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :status, :string
  end
end
