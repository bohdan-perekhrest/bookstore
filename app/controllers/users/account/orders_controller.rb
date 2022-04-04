# frozen_string_literal: true

module Users
  module Account
    class OrdersController < ApplicationController
      load_and_authorize_resource

      def index
        @orders = OrderQuery.new(@orders).by_filter(params[:filter]).map { |order| OrderPresenter.new(order) }
        @dropdown_presenter = DropdownsPresenter.new(params[:filter])
        redirect_to books_path, notice: I18n.t('order.missing') if @orders.empty?
      end

      def show
        @order_presenter = OrderPresenter.new(@order)
        @credit_card_presenter = CreditCardPresenter.new(@order.credit_card)
        @order_items = @order.order_items.map { |order_item| BookPresenter.new(order_item.book, order_item) }
      end
    end
  end
end
