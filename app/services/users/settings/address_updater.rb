# frozen_string_literal: true

module Users
  module Settings
    class AddressUpdater < ApplicationService
      def initialize(params, user_id)
        @params = params
        @user_id = user_id
      end

      def call
        address
        fill_in_address
        save_address
      end

      private

      attr_reader :params, :user_id

      def address
        @address = Address.where(type: params[:type], user_id: user_id).first_or_initialize
      end

      def address_params
        params.permit(:first_name, :last_name, :city, :zip, :country, :address, :phone)
      end

      def fill_in_address
        @address.assign_attributes(address_params)
      end

      def save_address
        @address.save if @address.valid?
      end
    end
  end
end
