require 'rails_helper'

RSpec.describe CheckoutController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  before { sign_in(user) }

  describe 'GET #show' do
    let(:order) { FactoryBot.create(:order, :in_progress, :with_order_item, user_id: user.id) }

    describe 'addresses tab' do
      before { get :show, params: { id: :addresses } }

      it 'render addresses view' do
        expect(response).to render_template :addresses
      end

      it 'assign @addresses' do
        expect(assigns(:addresses)).not_to be_nil
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end
    end

    describe 'delivery tab' do
      before do
        FactoryBot.create(:address, order_id: order.id)
        get :show, params: { id: :delivery }
      end

      it 'return http success' do
        expect(response).to have_http_status(:found)
      end
    end

    describe 'payment tab' do
      before { get :show, params: { id: :payment } }

      it 'return http success' do
        expect(response).to have_http_status(:found)
      end
    end

    describe 'confirm tab' do
      let(:credit_card) { FactoryBot.create(:credit_card) }
      before do
        order.update(credit_card_id: credit_card.id)
        get :show, params: { id: :confirm }
      end

      it 'render confirm view' do
        expect(response).to render_template :confirm
      end

      it 'return http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'PUT #update' do
    let!(:order) { FactoryBot.create(:order, :in_progress, :with_order_item, user_id: user.id) }

    describe 'delivery' do
      before do
        delivery = FactoryBot.create(:delivery)
        put :update, params: { id: :delivery, order: { delivery_id: delivery.id } }
      end

      it 'return http found' do
        expect(response).to have_http_status(:found)
      end
    end

    describe 'payment' do
      before do
        credit_card_attributes = FactoryBot.attributes_for(:credit_card)
        put :update, params: { id: :payment, credit_card: credit_card_attributes }
      end

      it 'assign @credit_card' do
        expect(assigns(:credit_card)).not_to be_nil
      end

      it 'return http found' do
        expect(response).to have_http_status(:found)
      end
    end

    describe 'confirm' do
      before do
        put :update, params: { id: :confirm }
      end

      it 'set session[:complete_order]' do
        expect(session[:complete_order]).to eq true
      end

      it 'return http found' do
        expect(response).to have_http_status(:found)
      end

      it 'clear order_id from session' do
        expect(session[:order_id]).to be_nil
      end
    end
  end
end
