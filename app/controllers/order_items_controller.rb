# frozen_string_literal: true

class OrderItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @order_item = current_order.order_items.find_or_initialize_by(order_item_params)
    redirect_to order_index_path if @order_item.save && current_order.save
  end

  def update
    redirect_to order_index_path if @order_item.update(quantity: order_item_params[:quantity]) && current_order.save
  end

  def destroy
    redirect_to order_index_path if @order_item.delete && current_order.save
  end

  private

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end
