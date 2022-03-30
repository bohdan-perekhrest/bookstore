# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:review_params) { FactoryBot.build(:review).attributes }
  let(:book_id) { FactoryBot.create(:book).id }
  login_user
  context 'with invalid save'do
    before do
      allow_any_instance_of(Review).to receive(:save).and_return false
    end

    it 'sends error flash' do
      post :create, params: { book_id: book_id, review: review_params }
      expect(flash[:alert]).to eq I18n.t('review.smth_went_wrong')
    end
  end

  context 'with valid save' do
    before do
      allow_any_instance_of(Review).to receive(:save).and_return true
    end

    it 'sends success flash' do
      post :create, params: { book_id: book_id, review: review_params }
      expect(flash[:notice]).to eq I18n.t('review.thanks_message')
    end
  end
end
