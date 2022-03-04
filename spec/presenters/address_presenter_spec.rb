# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AddressPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:address) { FactoryBot.create(:address, :with_user, type: 'Billing') }

  describe '#first_name' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return first_name from Billing' do
      expect(address_presenter.first_name).to eq(address.first_name)
    end
  end

  describe '#last_name' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return last_name from Billing' do
      expect(address_presenter.last_name).to eq(address.last_name)
    end
  end

  describe '#address' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return address from Billing' do
      expect(address_presenter.address).to eq(address.address)
    end
  end

  describe '#city' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return city from Billing' do
      expect(address_presenter.city).to eq(address.city)
    end
  end

  describe '#zip' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return zip from Billing' do
      expect(address_presenter.zip).to eq(address.zip)
    end
  end

  describe '#country' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return country from Billing' do
      expect(address_presenter.country).to eq(address.country)
    end
  end

  describe '#phone' do
    let(:address_presenter) { AddressPresenter.new(address.user, address.type) }
    it 'should return phone from Billing' do
      expect(address_presenter.phone).to eq(address.phone)
    end
  end
end

