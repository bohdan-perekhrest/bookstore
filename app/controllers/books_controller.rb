# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  include Pagy::Backend
  before_action :set_book, only: %i[show]

  def index
    @pagy, @books, @categories = CatalogGenerator.new(params).call
  end

  def show; end

  def new
    @book = Book.new
  end

  def create
    if Book.create(book_params)
      redirect_to root_path, notice: 'book was successfully create'
    else
      render :new, alert: 'book was not create'
    end
  end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
  end

  def book_params
    params.require(:book).permit(
      :name, :price, :category_id, :description, :image, :height, :width, :depth,
      :published_at, :materials
    )
  end
end
