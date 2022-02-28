# frozen_string_literal: true

module PriceHelper
  def currency_with_price(price=0.00)
    "€#{price}"
  end
end
