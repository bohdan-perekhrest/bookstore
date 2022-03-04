# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  include_examples 'address_validations'

  describe 'scopes' do
    before(:all) { FactoryBot.create_list(:address, 6) }

    describe 'shipping' do
      subject { FactoryBot.create(:address, type: 'Shipping') }

      it 'contain only one type of addresses' do
        expect(subject.type).to be_a String
      end

      it 'only shipping' do
        expect(subject.type).to eq 'Shipping'
      end
    end

    describe 'billing' do
      subject { FactoryBot.create(:address, type: 'Billing')} 

      it 'contain only one type of addresses' do
        expect(subject.type).to be_a String
      end

      it 'only shipping' do
        expect(subject.type).to eq 'Billing'
      end
    end
  end
end
