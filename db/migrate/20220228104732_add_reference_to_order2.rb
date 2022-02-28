class AddReferenceToOrder2 < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :credit_card, foreign_key: true, index: true
  end
end
