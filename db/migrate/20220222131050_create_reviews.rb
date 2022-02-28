class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :text
      t.timestamps
    end
    add_reference :reviews, :user, index: true, foreign_key: true
  end
end
