require 'rails_helper'

RSpec.describe Users::Settings::PrivacyController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before{ sign_in(user) }

  describe 'GET #index' do
    it 'return success status' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end
  end

  describe 'PUT #update email' do
    context 'valid email' do
      let(:valid_email_params) do
        { user: { email: 'blabla32@rubygarage.org', update_email: true } }
      end
      before { patch :update, params: valid_email_params }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to privacy_path
      end

      it 'show success message' do
        expect(flash[:notice]).to eq I18n.t('user.updated')
      end
    end

    context 'invalid email' do
      let(:invalid_email_params) do
        { user: { email: '--bla@va@#$m', update_email: true } }
      end
      before { patch :update, params: invalid_email_params }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to privacy_path 
      end

      it 'show error message' do
        expect(flash[:alert]).to eq I18n.t('user.not_updated')
      end
    end
  end

  describe 'update password' do
    let(:valid_password_params) do
      { user: {
        current_password: user.password,
        password: 'validQWERTY1z',
        password_confirmation: 'validQWERTY1z',
        update_password: true
       }
     }
    end
    let(:invalid_password_params) do
      { user: {
        current_password: user.password,
        password: 'invalid',
        password_confirmation: 'invalid',
        update_password: true
       }
     }
    end

    context 'valid password' do
      before { patch :update, params: valid_password_params }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to privacy_path
      end

      it 'show success message' do
        expect(flash[:notice]).to eq I18n.t('user.updated')
      end
    end

    context 'invalid password' do
      before { patch :update, params: invalid_password_params }

      it 'redirect_to settings privacy' do
        expect(response).to redirect_to privacy_path
      end

      it 'show error message' do
        expect(flash[:alert]).to eq I18n.t('user.not_updated')
      end
    end
  end
end
