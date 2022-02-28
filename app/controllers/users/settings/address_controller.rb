# frozen_string_literal: true

class Users::Settings::AddressController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def update
    if Users::Settings::AddressService.new(address_params, current_user.id).call
      redirect_to address_path, notice: 'address was updated!'
    else
      redirect_to address_path, alert: 'address was not updated!'
    end
  end

  private

  def address_params
    params.require(:address).permit(:first_name, :type, :last_name, :city, :zip, :country, :phone, :address)
  end
end
