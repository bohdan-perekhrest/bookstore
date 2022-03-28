# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentSession
  before_action :set_order_id

  private

  def set_order_id
    session[:order_id] ||= Order.create.id
    order = Order.find_by(id: session[:order_id])
    order.user = current_user if order.user_id.nil?
  end
end
