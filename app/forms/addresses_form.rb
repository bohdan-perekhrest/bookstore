# frozen_string_literal: true

class AddressesForm
  include ActiveModel::Model

  attr_reader :params, :target, :use_billing

  def initialize(params = {})
    @params = params
    @target = User.find_by(id: user_id) || Order.find_by(id: order_id)
    @billing = billing
    @shipping = shipping
  end

  def errors
    { billing: @billing.errors, shipping: @shipping.errors }
  end

  def billing
    target.addresses.find_or_initialize_by(type: Address.types['Billing'])
  end

  def shipping
    target.addresses.find_or_initialize_by(type: Address.types['Shipping'])
  end

  def persist!
    @billing.assign_attributes(params_for(:billing))
    @shipping.assign_attributes(params_for(:shipping))
    return false unless valid?

    ActiveRecord::Base.transaction do
      @billing.save
      @shipping.save
    end
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

  def valid?
    @billing.valid? & @shipping.valid?
  end

  def params_for(type)
    type = params[:use_billing] == '1' ? :billing : type
    params.require(type).permit(:first_name, :last_name, :city, :country, :zip, :phone, :address, :order_id, :user_id)
  end
end
