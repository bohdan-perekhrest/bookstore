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
        @addresses.persist!
        render :index
      end

      private

      def addresses_params
        params.require(:addresses_form)
      end
    end
  end
end
