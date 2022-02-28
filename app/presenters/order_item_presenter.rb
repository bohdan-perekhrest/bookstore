# frozen_string_literal: true

class OrderItemPresenter < BasePresenter
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def short_description
    "#{item.book.description.split('. ').first}."
  end
end
