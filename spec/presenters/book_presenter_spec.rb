# frozen_string_literal: true

require 'spec_helper'

RSpec.describe BookPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:book) { FactoryBot.create(:book, :with_authors) }

  context '#authors_full_names' do
    let(:book_presenter) { BookPresenter.new(book) }
    let(:authors_names) { book.authors.map {|a| "#{a.first_name} #{a.last_name}"}.join(', ') }

    it 'return authors full names of book' do
      expect(book_presenter.authors_full_names). to eq(authors_names)
    end
  end

  context '#dimensions' do
    let(:book_presenter) { BookPresenter.new(book) }
    let(:dimension) { "H:#{book.height}' x W:#{book.width}' x D:#{book.depth}'" }

    it 'return book height width depth' do
      expect(book_presenter.dimensions).to eq(dimension)
    end
  end
end

