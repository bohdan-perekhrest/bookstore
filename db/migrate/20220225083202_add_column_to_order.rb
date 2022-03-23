class AddColumnToOrder < ActiveRecord::Migration[6.1]
  def change
    add_reference :orders, :coupon, index: true, foreign_key: true
    add_reference :orders, :delivery, foreign_key: true, index: true
    add_reference :orders, :credit_card, foreign_key: true, index: true
  end
end
