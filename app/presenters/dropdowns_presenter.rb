# frozen_string_literal: true

class DropdownsPresenter < BasePresenter
  DROPDOWN = {
    newest: t('button.newest_first'),
    popular: t('button.popular_first'),
    price_up: t('button.low_to_hight'),
    price_down: t('button.hight_to_low'),
    a_z: t('button.title_A-Z'),
    z_a: t('button.title_A-Z'),
    all: t('order.status.all'),
    in_queue: t('order.status.in_queue'),
    in_delivery: t('order.status.in_delivery'),
    delivered: t('order.status.delivered'),
    canceled: t('order.status.canceled')
  }.freeze

  attr_reader :filter

  def initialize(filter)
    @filter = filter
  end

  def main_text
    filter ? DROPDOWN[filter.to_sym] : DROPDOWN[:newest]
  end

  def main_text_order
    filter ? DROPDOWN[filter.to_sym] : DROPDOWN[:all]
  end
end
