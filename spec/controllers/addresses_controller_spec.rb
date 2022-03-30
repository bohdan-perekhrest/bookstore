# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Settings::AddressController, type: :controller do
  login_user

  describe 'GET #index' do
    before { get :index }

    it 'return a success response' do
      expect(response.code).to eql('200')
      expect(response).to render_template :index
    end
  end

  describe 'Patch #update' do
    let(:address) { FactoryBot.attributes_for(:address) }
    before { patch :update, params: { address: address } }

    it 'render #index' do
      expect(response).to redirect_to('/settings/address')
    end
  end
end
