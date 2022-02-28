class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.string :zip
      t.string :city
      t.string :country
      t.string :phone
      t.string :address
      t.string :type
      t.timestamps
    end
    add_reference :addresses, :user, index: true, foreign_key: true
  end
end
