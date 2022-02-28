# frozen_string_literal: true

class CreditCardPresenter < BasePresenter
  attr_reader :credit_card

  def initialize(credit_card)
    @credit_card = credit_card
  end

  def secret_card_number
    "**** **** **** #{credit_card.number.last(4)}"
  end
end
