class AddReferenceToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :delivery, foreign_key: true, index: true
  end
end
