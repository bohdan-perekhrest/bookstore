# frozen_string_literal: true

class ReviewsService < ApplicationService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    create_review
  end

  private

  def create_review
    @review.new(review_params) do |review|
      review.user_id = user_id
      review.book_id = params[:book_id]
      review.star = 5
    end.save
  end

  def review_params
    params.require(:review).permit(:title, :text, :star)
  end
end
