class ChangeStatusReview < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :status
    add_column :reviews, :status, :integer, default: 0
  end
end
