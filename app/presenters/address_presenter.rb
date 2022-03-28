# frozen_string_literal: true

class AddressPresenter < BasePresenter
  attr_reader :user, :address

  def initialize(user, type)
    @user = user
    @type = type.downcase
    @address = public_send(@type)
  end

  def first_name
    return nil unless exist?

    @address.first_name
  end

  def last_name
    return nil unless exist?

    @address.last_name
  end

  def address
    return nil unless exist?

    @address.address
  end

  def city
    return nil unless exist?

    @address.city
  end

  def zip
    return nil unless exist?

    @address.zip
  end

  def country
    return nil unless exist?

    @address.country
  end

  def phone
    return nil unless exist?
    
    @address.phone
  end

  private

  def exist?
    @address.nil?
  end

  def billing
    user.billing || Billing.new
  end

  def shipping
    user.shipping || Shipping.new
  end
end
