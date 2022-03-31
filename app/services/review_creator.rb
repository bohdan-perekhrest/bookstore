# frozen_string_literal: true

class ReviewCreator < ApplicationService
  attr_reader :params, :user_id, :book_id

  def initialize(params, user_id:, book_id:)
    @params = params
    @user_id = user_id
    @book_id = book_id
  end

  def call
    Review.new(params) do |review|
      review.user_id = user_id
      review.book_id = book_id
    end.save
  end
end
