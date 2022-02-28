# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i[update destroy]

  def create
    @order_item = current_order.order_items.find_or_initialize_by(order_item_params)
    if @order_item.save && current_order.save
      redirect_to order_index_path, notice: 'Book was added!'
    else
      redirect_to order_index_path, alert: 'Book was not added!'
    end
  end

  def update
    if @order_item.update(quantity: order_item_params[:quantity]) && current_order.save
      redirect_to order_index_path, notice: 'Quantity was changed!'
    else
      redirect_to order_index_path, alert: 'Quantity  was not changed!'
    end
  end

  def destroy
    if @order_item.delete  && current_order.save
      redirect_to order_index_path, notice: 'Book was removed!'
    else
      redirect_to order_index_path, alert: 'Book was not removed!'
    end
  end

  private

  def set_order_item
    @order_item = OrderItem.find_by(id: params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:book_id, :quantity)
  end
end

