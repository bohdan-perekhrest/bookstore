# frozen_string_literal: true

class BooksController < ApplicationController
  include Pagy::Backend
  load_and_authorize_resource
  before_action :set_book, only: %i[show]
  respond_to :html, :js, only: %i[index]

  def index
    @pagy, @books, @categories = CatalogGenerator.new(params).call
  end

  def show; end

  private

  def set_book
    @book = Book.find_by(id: params[:id])
  end
end
