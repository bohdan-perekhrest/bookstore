# frozen_string_literal: true

class BookPresenter < BasePresenter
  include ApplicationHelper

  attr_reader :book

  def initialize(book)
    @book = book
  end

  def authors_full_names
    book.authors.map { |author| full_name(author) }.join(', ')
  end

  def dimensions
    "H:#{book.height}' x W:#{book.width}' x D:#{book.depth}'"
  end

  def truncate_description
    if book.description.length > 250
      markdown(book.description.truncate(250))
    else
      markdown(book.description)
    end
  end
end
