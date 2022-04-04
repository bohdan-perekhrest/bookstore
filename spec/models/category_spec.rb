require 'rails_helper'

RSpec.describe Category, type: :model do
  it { expect(subject).to validate_presence_of :name }
  it { expect(subject).to validate_uniqueness_of :name }

  describe 'scopes' do
    describe '#with_books_count' do
      before(:all) do
        @cat1 = FactoryBot.create(:category, :with_books_web)
        @cat2 = FactoryBot.create(:category, :with_books_mobile)
      end

      it 'fetch categories with amount of books in them' do
        expect(Category.find_by(id: @cat1.id).books.count).to eq 8
      end

      it 'fetch categories with amount of books in them' do
        expect(Category.find_by(id: @cat2.id).books.count).to eq 15
      end
    end
  end
end
