# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.book_id = params[:book_id]
    @review.status = 'unprocessed'
    @review.star = 5
    if @review.save
      redirect_to book_path(params[:book_id]),
                  notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to book_path(params[:book_id]), alert: 'review was not created!'
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :text, :star)
  end
end
