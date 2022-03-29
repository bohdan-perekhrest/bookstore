# frozen_string_literal: true

module Users
  module Account
    class OrdersController < ApplicationController
      load_and_authorize_resource :order

      def index
        @orders = OrderQuery.new(orders: @orders).by_filter(params[:filter])
      end

      def show; end
    end
  end
end
