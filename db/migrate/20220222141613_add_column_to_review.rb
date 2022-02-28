class AddColumnToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :star, :integer
    add_reference :reviews, :book, index: true, foreign_key: true
  end
end
