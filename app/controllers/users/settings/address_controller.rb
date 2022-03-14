# frozen_string_literal: true

module Users
  module Settings
    class AddressController < ApplicationController
      before_action :authenticate_user!
      load_and_authorize_resource

      def index; end

      def update
        if Users::Settings::AddressService.new(address_params, current_user.id).call
          redirect_to address_path, notice: I18n.t('user.updated')
        else
          redirect_to address_path, alert: I18n.t('user.not_updated')
        end
      end

      private

      def address_params
        params.require(:address).permit(:first_name, :type, :last_name, :city, :zip, :country, :phone, :address)
      end
    end
  end
end
