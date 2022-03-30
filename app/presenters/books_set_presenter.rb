# frozen_string_literal: true

class BooksSetPresenter
  SLICE_NUMBER = 4

  def initialize(books:)
    @books = books.map { |book| BookPresenter.new(book) }
  end

  def set
    @books.each_slice(SLICE_NUMBER).to_a
  end
end
