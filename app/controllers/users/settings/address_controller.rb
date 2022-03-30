# frozen_string_literal: true

module Users
  module Settings
    class AddressController < ApplicationController
      before_action :authenticate_user!

      def index
        @addresses = AddressesForm.new(user_id: current_user.id)
      end

      def update
        @addresses = AddressesForm.new(addresses_params)
        if @addresses.persist!
          redirect_to address_path, notice: I18n.t('user.updated')
        else
          redirect_to address_path, alert: I18n.t('user.not_updated')
        end
      end

      private

      def addresses_params
        params.require(:addresses_form)
      end
    end
  end
end
