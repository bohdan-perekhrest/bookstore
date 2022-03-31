require 'spec_helper'

RSpec.describe BooksQuery, type: :model do
  before do
    15.times { FactoryBot.create(:book, price: rand(1..300)) }
  end
  subject { BooksQuery.new }

  it 'unless give set to query it will work with all books' do
    expect(subject.relation).to eq Book.all
  end

  %w[newest popular price_up price_down].each do |method|
    it "call #{method} when receive params '#{method}'" do
      expect(subject).to receive(method)
      subject.send(method)
    end
  end

  it 'return set of books prices from hight to low' do
    result = subject.send('price_up')
    expect(result[0].price).to be <= result[1].price
    expect(result[1].price).to be <= result[2].price
  end

  it 'return set of books prices from low to hight' do
    result = subject.send('price_down')
    expect(result[0].price).to be >= result[1].price
    expect(result[1].price).to be >= result[2].price
  end

  it 'return newest set of books' do
    result = subject.send('newest')
    expect(result[0].created_at).to be >= result[1].created_at
    expect(result[1].created_at).to be >= result[2].created_at
  end
end
