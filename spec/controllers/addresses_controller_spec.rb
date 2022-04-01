require 'rails_helper'

RSpec.describe Users::Settings::AddressController, type: :controller do
  let(:user) { FactoryBot.create(:user)}
  login_user

  describe 'GET #index' do
    before { get :index }

    it 'return a success response' do
      expect(response.code).to eql('200')
      expect(response).to render_template :index
    end
  end

  describe 'Patch #update' do
    let(:billing) { FactoryBot.attributes_for(:address) }
    let(:shipping) { FactoryBot.attributes_for(:address) }
    let(:addresses_form) { {billing: billing, shipping: shipping, use_billing: '0', user_id: user.id} }
    before { patch :update, params: { addresses_form: addresses_form } }

    it 'render #index' do
      expect(response.code).to eql('200')
    end
  end
end
