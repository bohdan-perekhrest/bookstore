# frozen_string_literal: true

module CurrentSession
  thread_mattr_accessor :user

  extend ActiveSupport::Concern
  included do
    around_action :set_current_user
    helper_method :current_order
  end

  def current_order
    @current_order ||= Order.find_by(id: order_id)
  end

  def set_current_user
    CurrentSession.user = current_user
    yield
  ensure
    CurrentSession.user = nil
  end

  private

  def order_id
    current_user ? current_user.order_in_progress.id : session[:order_id]
  end
end
