# frozen_string_literal: true

class ReviewsController < ApplicationController
  load_and_authorize_resource

  def create
    if ReviewCreator.new(params, current_user.id).call
      redirect_to book_path(params[:book_id]), notice: I18n.t('review.thanks_message')
    else
      redirect_to book_path(params[:book_id]), alert: I18n.t('review.smth_went_wrong')
    end
  end
end
