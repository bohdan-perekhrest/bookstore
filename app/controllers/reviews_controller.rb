# frozen_string_literal: true

class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    @review = ReviewCreator.new(review_params, user_id: current_user.id, book_id: params[:book_id]).call
    redirect_to book_path(params[:book_id]),
                notice: (@review.save ? I18n.t('review.thanks_message') : I18n.t('review.smth_went_wrong'))
  end

  private

  def review_params
    params.require(:review).permit(:title, :text, :star)
  end
end
