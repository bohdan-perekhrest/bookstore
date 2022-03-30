# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ReviewPresenter do
  let(:view) { ActionController::Base.new.view_context }
  let(:review) { FactoryBot.create(:review, :with_user) }
  let(:review_presenter) { ReviewPresenter.new(review) }

  context '#user_full_name' do
    it 'should return user email' do
      expect(review_presenter.user_full_name).to eq(review.user.email)
    end
  end
  
  context '#created_at_formated' do
    let(:result) { review.created_at.strftime('%d/%m/%y') }

    it 'should return formated date created' do
      expect(review_presenter.created_at_formated).to eq(result)
    end
  end

  context '#number_of_empty_stars' do
    it 'should return number of empty stars' do
      expect(review_presenter.number_of_empty_stars).to eq(0)
    end
  end

  context '#verified?' do
    it 'should return false' do
      expect(review_presenter.verified?).to eq(false)
    end
  end
end

