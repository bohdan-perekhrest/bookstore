# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include CurrentSession
  before_action :set_order_id, :set_header_presenter

  private

  def set_order_id
    session[:order_id] ||= Order.create.id
    order = Order.find_by(id: session[:order_id])
    order.update(user: current_user) if order.user_id.nil?
  end

  def set_header_presenter
    @header_presenter = HeaderPresenter.new(session[:order_id])
  end
end
