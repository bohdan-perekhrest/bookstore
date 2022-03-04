# frozen_string_literal: true

class ReviewsService < ApplicationService
  attr_reader :params, :user_id

  def initialize(params, user_id)
    @params = params
    @user_id = user_id
  end

  def call
    create_review
  end

  private

  def create_review
    Review.new(review_params) do |review|
      review.user_id = user_id
      review.book_id = params[:book_id]
    end.save
  end

  def review_params
    params.require(:review).permit(:title, :text, :star)
  end
end
