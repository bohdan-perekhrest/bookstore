# frozen_string_literal: true

class CartsController < ApplicationController
  load_and_authorize_resource :order
  before_action :set_coupon, only: %i[update]

  def index
    @order_items = @order.order_items
  end

  def update
    @order.update_attribute(:coupon_id, @coupon.id) if @coupon
    redirect_to order_index_path, notice: @coupon ? I18n.t('flash.coupon_applied') : I18n.t('flash.fake_coupon')
  end

  private

  def set_coupon
    @coupon ||= Coupon.find_by(code: params[:code])
  end
end

