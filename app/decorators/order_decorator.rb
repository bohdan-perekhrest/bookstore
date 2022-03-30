# frozen_string_literal: true

class OrderDecorator < Draper::Decorator
  delegate_all
  ORDER_STATUSES = {
    in_progress: I18n.t('order.status.in_progress'),
    in_queue: I18n.t('order.status.in_queue'),
    in_delivery: I18n.t('order.status.in_delivery'),
    delivered: I18n.t('order.status.delivered'),
    canceled: I18n.t('order.status.canceled')
  }.freeze

  def complited_at
    object.updated_at.strftime('%F')
  end

  def number
    id = object.id.to_s
    template = 'R0000000'
    template[0..-id.size] + id
  end

  def status
    ORDER_STATUSES[object.status.to_sym]
  end

  def creation_date
    data = object.updated_at
    I18n.t('date.month_names')[data.month] + " #{data.strftime('%d, %Y')}"
  end
end
