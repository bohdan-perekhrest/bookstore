# frozen_string_literal: true

class CartsController < ApplicationController
  def index
    @order_items = current_order.order_items.map { |order_item| BookPresenter.new(order_item.book, order_item) }
    redirect_to books_path, notice: I18n.t('cart.missing') if @order_items.empty?
  end

  def update
    current_order.update(coupon_id: coupon.id) if coupon
    redirect_to order_index_path, notice: coupon ? I18n.t('flash.coupon_applied') : I18n.t('flash.fake_coupon')
  end

  private

  def coupon
    @coupon ||= Coupon.find_by(code: params[:code])
  end
end
