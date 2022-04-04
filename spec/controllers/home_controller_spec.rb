require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before { @books = FactoryBot.create_list(:book, 3) }

  describe 'GET #index' do
    before { get :index }

    it 'assign @latest_books' do
      expect(assigns(:latest_books)).not_to be_nil
      expect(response).to render_template :index
    end

    it 'assign @best_sellers' do
      expect(assigns(:best_sellers)).not_to be_nil
      expect(response).to have_http_status(:success)
    end
  end
end
