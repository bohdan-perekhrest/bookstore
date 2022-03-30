# frozen_string_literal: true

class CreditCardPresenter < BasePresenter
  NUMBER_OF_LAST_NUMBERS = 4

  attr_reader :credit_card

  def initialize(credit_card)
    @credit_card = credit_card
  end

  def secret_card_number
    '**** **** **** ' + credit_card.number.last(NUMBER_OF_LAST_NUMBERS) 
  end
end
