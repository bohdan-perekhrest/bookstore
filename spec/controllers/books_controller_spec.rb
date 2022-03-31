require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:book) { FactoryBot.create(:book) }

  describe 'GET #index' do
    before { get :index }

    it 'return a success response' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template :index
    end

    it 'assign @books' do
      expect(assigns(:books)).not_to be_nil
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: book.to_param } }

    it 'return a success response' do
      expect(response).to have_http_status(:success)
      expect(response).to render_template :show
    end
  end
end
