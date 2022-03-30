# frozen_string_literal: true

class OrderPresenter < BasePresenter
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def email
    "#{I18n.t('complete.has_been_sent_to')} #{order.user.email}"
  end

  def sharp_number
    "#{I18n.t('complete.order')} #{order.number}"
  end

  def delivery_name
    order.delibery.name
  end

  def delivery_duration
    order.delivery.duration
  end

  def credit_card_date
    order.credit_card.mm_yy
  end
end
