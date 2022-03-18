# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :category
  include Pagy::Backend

  def index
    @pagy, @books, @categories = Books::BooksGenerator.new(params, books: @books, categories: @categories).call
  end

  def create
    if Book.create(book_params)
      redirect_to root_path, notice: 'book was successfully create'
    else
      render :new, alert: 'book was not create'
    end
  end

  private

  def book_params
    params.require(:book).permit(
      :name, :price, :category_id, :description, :image, :height, :width, :depth,
      :published_at, :materials
    )
  end
end
