# frozen_string_literal: true

module Updateable
  extend ActiveSupport::Concern

  included do
    private

    def update_addresses
      @addresses = CheckoutAddressesForm.new(addresses_params)
      render_wizard unless @addresses.save
    end

    def update_delivery
      current_order.update(order_params)
      flash[:notice] = t('delivery.pickup') if current_order.delivery_id.nil?
    end

    def update_payment
      @credit_card = CreditCard.new(credit_card_params)
      render_wizard unless @credit_card.save
    end

    def update_confirm
      session[:order_id] = nil if current_order.finalize
      session[:complete_order] = true
    end

    def credit_card_params
      params.require(:credit_card).permit(:number, :name, :mm_yy, :cvv)
    end

    def order_params
      params.require(:order).permit(:delivery_id)
    end

    def addresses_params
      params.require(:checkout_addresses_form)
    end
  end
end
