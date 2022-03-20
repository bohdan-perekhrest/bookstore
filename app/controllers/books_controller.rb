# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :category
  respond_to :html, :js, only: %i[index]
  include Pagy::Backend

  def index
    @pagy, @books, @categories = Books::BooksGenerator.new(params, books: @books, categories: @categories).call
  end

  def show; end
end
