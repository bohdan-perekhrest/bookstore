# frozen_string_literal: true

module Users
  module Settings
    class AddressService < ApplicationService
      attr_reader :params, :user_id

      VARIABLES = %i[first_name last_name city zip country address phone].freeze

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

      def address
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
  end
end
