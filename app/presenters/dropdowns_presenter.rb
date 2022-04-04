# frozen_string_literal: true

class DropdownsPresenter < BasePresenter
  DROPDOWN = {
    newest: I18n.t('button.newest_first'),
    popular: I18n.t('button.popular_first'),
    price_up: I18n.t('button.low_to_hight'),
    price_down: I18n.t('button.hight_to_low'),
    a_z: I18n.t('button.title_A-Z'),
    z_a: I18n.t('button.title_A-Z'),
    all: I18n.t('order.status.all'),
    in_queue: I18n.t('order.status.in_queue'),
    in_delivery: I18n.t('order.status.in_delivery'),
    delivered: I18n.t('order.status.delivered'),
    canceled: I18n.t('order.status.canceled')
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
