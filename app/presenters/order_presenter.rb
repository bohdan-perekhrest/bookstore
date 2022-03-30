# frozen_string_literal: true

class OrderPresenter < BasePresenter
  attr_reader :order

  ORDER_STATUSES = {
    in_progress: I18n.t('order.status.in_progress'),
    in_queue: I18n.t('order.status.in_queue'),
    in_delivery: I18n.t('order.status.in_delivery'),
    delivered: I18n.t('order.status.delivered'),
    canceled: I18n.t('order.status.canceled')
  }.freeze

  def initialize(order)
    @order = order
  end

  def status
    ORDER_STATUSES[order.status.to_sym]
  end

  def email
    "#{I18n.t('complete.has_been_sent_to')} #{order.user.email}"
  end

  def sharp_number
    "#{I18n.t('complete.order')} #{order.number}"
  end
end
