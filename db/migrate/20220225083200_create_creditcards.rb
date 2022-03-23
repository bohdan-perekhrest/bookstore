class CreateCreditcards < ActiveRecord::Migration[6.1]
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.integer :cvv
      t.string :mm_yy
      t.string :number
      t.timestamps
    end
  end
end
