# frozen_string_literal: true

class HeaderPresenter < BasePresenter

  attr_reader :order_id

  def initialize(order_id)
    @order_id = order_id
  end

  def order_items_count
    Order.find_by(id: order_id).order_items.count
  end
end

