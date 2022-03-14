class UpdateReviews < ActiveRecord::Migration[6.1]
  def change
    remove_reference :reviews, :user
    remove_reference :reviews, :book
    add_reference :reviews, :user, foreign_key: { on_delete: :cascade}, index: true
    add_reference :reviews, :book, foreign_key: { on_delete: :cascade }, index: true
  end
end
