# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_coupon, only: %i[update]

  def index
    @order_items = current_order.order_items
  end

  def update
    current_order.update_attribute(:coupon_id, @coupon.id) if @coupon
    redirect_to order_index_path, notice: @coupon ? 'coupon was added to order!' : 'coupon fake'
  end

  private

  def set_coupon
    @coupon ||= Coupon.find_by(code: params[:code])
  end
end

