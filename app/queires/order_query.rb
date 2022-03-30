# frozen_string_literal: true

class OrderQuery
  attr_reader :relation, :user_id

  def initialize(relation = Order.all, user_id:)
    @relation = relation
    @user_id = user_id
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
    relation.where(user_id: user_id).where.not(status: 'in_progress')
  end

  def in_queue
    all.where(status: 'in_queue')
  end

  def in_delivery
    all.where(status: 'in_delivery')
  end

  def delivered
    all.where(status: 'delivered')
  end

  def canceled
    all.where(status: 'canceled')
  end
end
