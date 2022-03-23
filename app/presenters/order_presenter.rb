# frozen_string_literal: true

class OrderPresenter < BasePresenter
  attr_reader :order

  def initialize(order)
    @order = order
  end

  def email
    "#{I18n.t('complete.has_been_sent_to')} #{order.user.email.capitalize}"
  end

  def sharp_number
    "#{I18n.t('complete.order')} #{number}"
  end

  def creation_date
    date = order.updated_at
    "#{I18n.t('date.month_names')[date.month]} #{date.strftime('%d, %Y')}"
  end

  private

  def number
    id = order.id.to_s
    template = 'R0000000'
    template[0..-id.size] + id
  end
end
