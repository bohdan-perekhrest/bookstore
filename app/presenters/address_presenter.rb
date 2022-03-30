# frozen_string_literal: true

class AddressPresenter < BasePresenter
  attr_reader :user, :address

  def initialize(user, type)
    @user = user
    @type = type.downcase
    @address = public_send(@type)
  end

  def billing
    user.billing || Billing.new
  end

  def shipping
    user.shipping || Shipping.new
  end
end
