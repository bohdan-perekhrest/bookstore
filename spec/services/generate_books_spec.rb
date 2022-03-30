# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Book::BooksGenerator do
  before do
    15.times { FactoryBot.create(:book) } 
  end

  let(:category) { Category.first }
  context '#call' do
    let(:params) { {category_id: category.id} }
    let(:params1) { {filter: :price_up} }
    
    it 'should return pagy and books by category_id sorted' do
      pagy, books = BookService::GenerateBooks.new(params).call
      expect(books.first.first.category_id).to eq(category.id)
      expect(pagy).to be_a Pagy
    end

    it 'should return pagy and books by filter sorted' do
      pagy, books = BookService::GenerateBooks.new(params).call
      expect(books[0][0].price).to be >= books[0][1].price
      expect(books.size).to eq(2)
      expect(books[0].size).to eq(4)
    end
  end
end
