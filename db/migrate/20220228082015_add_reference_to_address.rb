class AddReferenceToAddress < ActiveRecord::Migration[6.1]
  def change
    add_reference :addresses, :order, foreign_key: true, index: true
  end
end
