require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'assign @order_items' do
      expect(assigns(:order_items)).not_to be_nil
    end

    it 'return index template' do
      expect(response).to redirect_to('/books')
    end
  end

  describe 'Put #update' do
    let!(:coupon) { FactoryBot.create(:coupon, code: 'D12345678900000', value: 33.33) }

    it 'set coupon' do
      expect(controller).to receive(:coupon).at_least(:once)
      put :update, params: { use_route: '/order' }
    end

    context 'fake coupon' do
      before { put :update, params: { use_route: '/order', code: 'invalid coupon' } }

      it 'redirect to Cart' do
        expect(response).to redirect_to order_index_path
      end

      it 'show failed message' do
        expect(flash[:notice]).to eq I18n.t('flash.fake_coupon')
      end
    end

    context 'valid coupon' do
      before { put :update, params: { use_route: '/order', code: 'D12345678900000' } }

      it 'redirect to Cart' do
        expect(response).to redirect_to order_index_path
      end

      it 'show success message' do
        expect(flash[:notice]).to eq I18n.t('flash.coupon_applied')
      end
    end
  end
end
