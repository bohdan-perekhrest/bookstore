# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :coupon, only: %i[update]

  def index
    @order_items = current_order.order_items
    return redirect_to books_path if @order_items.empty?
  end

  def update
    current_order.update(coupon_id: @coupon.id) if @coupon
    redirect_to order_index_path, notice: @coupon ? I18n.t('flash.coupon_applied') : I18n.t('flash.fake_coupon')
  end

  private

  def coupon
    @coupon ||= Coupon.find_by(code: params[:code])
  end
end
