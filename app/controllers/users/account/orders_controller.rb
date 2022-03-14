# frozen_string_literal: true

module Users
  module Account
    class OrdersController < ApplicationController
      before_action :order
      load_and_authorize_resource

      def index
        @orders = OrderQuery.new(user_id: current_user.id).by_filter(params[:filter]).map(&:decorate)
      end

      def show; end

      private

      def order
        @order = Order.find_by(id: params[:id]).decorate
      end
    end
  end
end
