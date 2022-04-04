# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :js, only: %i[index]
  include Pagy::Backend

  def index
    @pagy, @books = Books::BooksGenerator.new(params, books: @books).call
    @categories = Category.accessible_by(current_ability).with_books_count
    @books_set_presenter = BooksSetPresenter.new(books: @books)
    @dropdown_presenter = DropdownsPresenter.new(params[:filter])
  end

  def show
    @book_presenter = BookPresenter.new(@book)
    @reviews_presenter = @book.reviews.approved.map { |review| ReviewPresenter.new(review) }
  end
end
