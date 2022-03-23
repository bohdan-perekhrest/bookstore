# frozen_string_literal: true

class ReviewPresenter < BasePresenter
  MAX_STARS = 5

  attr_reader :review

  def initialize(review)
    @review = review
  end

  def user_full_name
    "#{review.user.billing.first_name} #{review.user.billing.last_name}"
  end

  def created_at_formated
    review.created_at.strftime('%d/%m/%y')
  end

  def number_of_empty_stars
    MAX_STARS - review.star
  end

  def verified_user
    # TODO: when there is be orders add verified user
  end
end
