# frozen_string_literal: true

class CheckoutAddressesForm
  include ActiveModel::Model

  def initialize(params = {})
    @params = params
    @target = Order.find_by(id: order_id) || User.find_by(id: user_id)
  end

  def errors
    { billing: billing.errors, shipping: shipping.errors }
  end

  def billing
    @billing = target.addresses.find_or_initialize_by(type: Address.types[:billing])
  end

  def shipping
    @shipping = target.addresses.find_or_initialize_by(type: Address.types[:shipping])
  end

  private

  attr_reader :params, :target, :use_billing

  def order_id
    params.fetch(:order_id, false) || (params[:billing][:order_id] if nested?)
  end

  def user_id
    params.fetch(:user_id, false) || (params[:billing][:user_id] if nested?)
  end

  def nested?
    params.fetch(:billing, false)
  end

  def persist!
    return false unless valid?

    @billing.assign_attributes(params_for(:billing))
    @shipping.assign_attributes(params_for(:shipping))
    ActiveRecord::Base.transaction do
      billing.save
      shipping.save
    end
  end

  def valid?
    billing.valid? & shipping.valid?
  end

  def params_for(type)
    type = params[:use_billing] == '1' ? :billing : type
    params.require(type).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :order_id, :user_id)
  end
end
