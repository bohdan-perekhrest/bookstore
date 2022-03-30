# frozen_string_literal: true

require 'spec_helper'

RSpec.describe CreditCardPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:credit_card) { FactoryBot.create(:credit_card) }

  context '#secret_card_number' do
    let(:credit_card_presenter) { CreditCardPresenter.new(credit_card) }
    let(:masked_code) { "**** **** **** #{credit_card.number.last(4)}" }

    it 'should return masked code number' do
      expect(credit_card_presenter.secret_card_number).to eq(masked_code)
    end
  end
end

