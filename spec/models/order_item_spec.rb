require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  let(:book) { FactoryBot.create(:book, price: 12.66) }
  let(:params) { [:order_item, book_id: book.id, quantity: 2] }

  it 'return total price' do
    order_i = FactoryBot.create(*params)
    expect(order_i.total_price).to eq 25.32
  end
end
