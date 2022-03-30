# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let!(:user) { FactoryBot.create(:user) }
  let!(:order) { FactoryBot.create(:order, :in_progress, :with_order_item, user_id: user.id) }
  let(:book) { FactoryBot.create(:book) }
  before { sign_in(user) }

  describe 'POST #create' do
    let(:create_params) { { order_item: { book_id: book.id, quantity: 1 } } }
    before { post :create, xhr: true,  params: create_params }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assign order_id to session' do
      expect(session[:order_id]).to eq order.id
    end
  end

  describe 'PUT #update' do
    let(:update_params) do
      { id: order.order_items.first.id, order_item: { quantity: 2 } }
    end
    before { put :update, xhr: true,  params: update_params }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'assign @order_items' do
      xpect(assigns(:order_items)).to match_array(order.order_items)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete :destroy, xhr: true,  params: { id: order.order_items.last.id }
      expect(response).to have_http_status(:success)
    end
  end
ende
