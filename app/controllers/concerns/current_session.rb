# frozen_string_literal: true

module CurrentSession
  thread_mattr_accessor :user

  extend ActiveSupport::Concern
  included do
    around_action :set_current_user
    helper_method :current_order

    def after_sign_in_path_for(resource)
      if cookies[:from_checkout]
        cookies.delete :from_checkout
        checkout_path(:addresses)
      else
        super
      end
    end
  end

  def current_order
    @order ||= Order.find_by(id: order_id)
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
