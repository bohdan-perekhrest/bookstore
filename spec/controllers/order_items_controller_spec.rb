require 'rails_helper'

RSpec.describe OrderItemsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:order) { FactoryBot.create(:order, :with_order_item, user_id: user.id) }
  let(:book) { FactoryBot.create(:book) }
  before { sign_in(user) }

  describe 'POST #create' do
    let(:create_params) { { order_item: { book_id: book.id, quantity: 1 } } }
    before { post :create,  params: create_params }

    it 'returns http success' do
      expect(response).to have_http_status(:found)
    end
  end

  describe 'PUT #update' do
    let(:update_params) do
      { id: order.order_items.first.id, order_item: { quantity: 2 } }
    end
    before { put :update,  params: update_params }

    it 'returns http success' do
    
      expect(response).to have_http_status(:found)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns http success' do
      delete :destroy, xhr: true,  params: { id: order.order_items.last.id }
      expect(response).to have_http_status(:success)
    end
  end
end
