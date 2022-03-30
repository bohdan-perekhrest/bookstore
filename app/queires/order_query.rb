# frozen_string_literal: true

class OrderQuery
  attr_reader :relation, :user_id

  delegate :in_queue, :in_delivery, :delivered, :canceled, to: :all

  def initialize(relation = Order.all)
    @relation = relation
  end

  def by_filter(filter)
    case filter
    when 'in_queue' then in_queue
    when 'in_delivery' then in_delivery
    when 'delivered' then delivered
    when 'canceled' then canceled
    else all
    end
  end

  private

  def all
    relation.where.not(status: 'in_progress')
  end
end
