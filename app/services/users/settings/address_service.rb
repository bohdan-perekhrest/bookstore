# frozen_string_literal: true

class Users::Settings::AddressService < ApplicationService
  attr_reader :params, :user_id

  VARIABLES = %i[first_name last_name city zip country address phone]

  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def call
    get_address
    fill_in_address
    save_address
  end

  private

  def get_address
    @address = Address.where(type: params[:type], user_id: user_id).first_or_initialize
  end

  def fill_in_address
    VARIABLES.each do |var|
      @address.send("#{var}=", params[var]) if params[var]
    end
  end

  def save_address
    @address.save if @address.valid?
  end
end
