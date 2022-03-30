# frozen_string_literal: true

class BookPresenter < BasePresenter
  include ApplicationHelper

  DESCRIPTION_LENGTH = 250
  SHORT_DESCRIPTION_LENGTH = 75

  attr_reader :book, :order_item

  def initialize(book, order_item = nil)
    @book = book
    @order_item = order_item
  end

  def authors_full_names
    book.authors.map { |author| full_name(author) }.join(', ')
  end

  def dimensions
    "H:#{book.height}' x W:#{book.width}' x D:#{book.depth}'"
  end

  def truncate_description
    if book.description.length > DESCRIPTION_LENGTH
      markdown(book.description.truncate(DESCRIPTION_LENGTH))
    else
      markdown(book.description)
    end
  end

  def short_description
    book.description.truncate(SHORT_DESCRIPTION_LENGTH)
  end
end
