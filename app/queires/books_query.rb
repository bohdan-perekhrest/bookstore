# frozen_string_literal: true

class BooksQuery
  attr_reader :relation

  def initialize(relation = Book.all)
    @relation = relation
  end

  def by_filter(filter_params)
    case filter_params
    when 'newest' then newest
    when 'popular' then popular
    when 'price_up' then price_up
    when 'price_down' then price_down
    when 'a_z' then title_a_z
    when 'z_a' then title_z_a
    else newest
    end
  end

  def by_category(category_id)
    relation.where(category_id: category_id)
  end

  private

  def newest
    relation.order(updated_at: :desc)
  end

  def popular
    relation.left_outer_joins(orders: [:order_items])
            .includes(:authors)
            .group(:id)
            .order('SUM(order_items.quantity)')
  end

  def price_up
    relation.order(price: :asc)
  end

  def price_down
    relation.order(price: :desc)
  end

  def title_a_z
    relation.order(name: :asc)
  end

  def title_z_a
    relation.order(name: :desc)
  end
end
