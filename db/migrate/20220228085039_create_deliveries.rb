class CreateDeliveries < ActiveRecord::Migration[6.1]
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :duration
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
