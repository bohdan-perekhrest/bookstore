class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :code
      t.decimal :value, precision: 8, scale: 2
      t.timestamps
    end
  end
end
