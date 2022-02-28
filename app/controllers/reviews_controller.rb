# frozen_string_literal: true

class ReviewsController < ApplicationController
  def create
    save = ReviewsService.new(params).call
    @review.status = 'unprocessed'
    if save
      redirect_to book_path(params[:book_id]),
                  notice: 'Thanks for Review. It will be published as soon as Admin will approve it.'
    else
      redirect_to book_path(params[:book_id]), alert: 'review was not created!'
    end
  end
end
