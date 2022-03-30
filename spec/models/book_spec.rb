# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  context 'validations' do
    it { expect(subject).to validate_presence_of :name }
    it { expect(subject).to validate_presence_of :price }
    it { expect(subject).to validate_presence_of :description }
    it { expect(subject).to validate_presence_of :published_at }
    it { expect(subject).to validate_presence_of :height }
    it { expect(subject).to validate_presence_of :width }
    it { expect(subject).to validate_presence_of :depth }
    it { expect(subject).to validate_presence_of :materials }
    it {
      expect(subject).to validate_numericality_of(:price)
        .is_greater_than_or_equal_to 0.01
    }
    it {
      expect(subject).to validate_numericality_of(:published_at)
        .is_greater_than_or_equal_to(1900)
        .is_less_than_or_equal_to Time.zone.now.year
    }
    it { expect(subject).to validate_numericality_of(:height) }
    it { expect(subject).to validate_numericality_of(:width) }
    it { expect(subject).to validate_numericality_of(:depth) }
    it { expect(subject).to validate_length_of(:name).is_at_most 120 }
    it { expect(subject).to validate_length_of(:materials).is_at_most 80 }
    it {
      expect(subject).to validate_length_of(:description)
        .is_at_least(5).is_at_most(2000)
    }
    it { expect(subject).to have_many :authors_books }
    it { expect(subject).to have_many :authors }
  end

  describe 'bestsellers' do
    before do
      @photo_book = FactoryBot.create(:book, category_name: 'Photo', name: 'Photo book')
      @web_book = FactoryBot.create(:book, category_name: 'Web', name: 'Web book')
      @design_book = FactoryBot.create(:book, category_name: 'Design', name: 'Design book')
      @dev_book = FactoryBot.create(:book, category_name: 'Dev', name: 'Dev book')

      FactoryBot.create(:order_item_with_delivered_book,
        book: FactoryBot.create(:book, category_name: 'Web')
      )
      FactoryBot.create(:order_item_with_delivered_book,
        book: FactoryBot.create(:book, category_name: 'Photo')
      )
      FactoryBot.create(:order_item_with_delivered_book,
        book: FactoryBot.create(:book, category_name: 'Design')
      )
      FactoryBot.create(:order_item_with_delivered_book,
        book: FactoryBot.create(:book, category_name: 'Dev')
      )

      FactoryBot.create_list(:order_item_with_delivered_book, 3, book: @photo_book)
      FactoryBot.create_list(:order_item_with_delivered_book, 2, book: @web_book)
      FactoryBot.create_list(:order_item_with_delivered_book, 3, book: @design_book)
      FactoryBot.create_list(:order_item_with_delivered_book, 2, book: @dev_book)
      FactoryBot.create_list(:order_item, 7)
    end

    it 'return bestsellers in each category' do
      expect(Book.best_sellers.pluck(:id)).to match_array [
        @photo_book.id, @web_book.id, @design_book.id, @dev_book.id
      ]
    end
  end
end
