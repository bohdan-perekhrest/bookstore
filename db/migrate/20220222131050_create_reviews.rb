class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :text
      t.integer :star
      t.integer :status
      t.string :aasm_state
      t.timestamps
    end
    add_reference :reviews, :user, index: true, foreign_key: { on_delete: :cascade }
    add_reference :reviews, :book, index: true, foreign_key: { on_delete: :cascade }
  end
end
