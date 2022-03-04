# frozen_string_literal: true

class CheckoutAddressesForm
  include ActiveModel::Model

  attr_reader :params, :target, :use_billing

  def initialize(params)
    @params = params
    @target = Order.find_by(id: order_id) || User.find_by(id: user_id)
    @save = false
  end

  def errors
    { billing: billing.errors, shipping: shipping.errors }
  end

  def save
    @save = true
    return false unless valid?

    persist!
    true
  end

  def billing
    bill = target.addresses.find_or_initialize_by(type: 'Billing')
    bill.assign_attributes(params_for(:billing)) if save?
    @billing ||= bill
  end

  def shipping
    ship = target.addresses.find_or_initialize_by(type: 'Shipping')
    ship.assign_attributes(params_for(:shipping)) if save?
    @shipping ||= ship
  end

  private

  def order_id
    params.fetch(:order_id, false) || (params[:billing][:order_id] if nested?)
  end

  def user_id
    params.fetch(:user_id, false) || (params[:billing][:user_id] if nested?)
  end

  def nested?
    params.fetch(:billing, false)
  end

  def save?
    @save
  end

  def persist!
    billing.save
    shipping.save
  end

  def valid?
    shipping.valid?
    billing.valid? && shipping.valid?
  end

  def params_for(type)
    type = params[:use_billing] == '1' ? :billing : type
    params.require(type).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :order_id, :user_id)
  end
end
