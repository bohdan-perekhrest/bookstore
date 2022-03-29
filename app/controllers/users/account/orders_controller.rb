# frozen_string_literal: true

module Users
  module Account
    class OrdersController < ApplicationController
      load_and_authorize_resource :order

      def index
        @orders = OrderQuery.new(orders: @orders).by_filter(params[:filter]).map { |order| OrderPresenter.new(order) }
        @dropdown_presenter = DropdownsPresenter.new(params[:filter])
      end

      def show
        @order_presenter = OrderPresenter.new(@order)
        @credit_card_presenter = CreditCardPresenter.new(@order.credit_card)
        @order_items = @order.order_items.map { |order_item| BookPresenter.new(order_item.book) }
      end
    end
  end
end
