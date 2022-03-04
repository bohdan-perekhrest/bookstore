# frozen_string_literal: true

class DropdownsPresenter < BasePresenter
  DROPDOWN = {
    newest: 'Newest first',
    popular: 'Popular first',
    price_up: 'Price: Low to high',
    price_down: 'Price: High to low',
    a_z: 'Title A - Z',
    z_a: 'Title Z - A',
    in_queue: 'Waiting for processing',
    in_delivery: 'In Delivery',
    delivered: 'Delivered',
    canceled: 'Canceled'
  }.freeze

  attr_reader :filter

  def initialize(filter)
    @filter = filter
  end

  def main_text
    filter ? DROPDOWN[filter.to_sym] : 'Newest first'
  end

  def main_text_order
    filter ? DROPDOWN[filter.to_sym] : 'All Orders'
  end
end
