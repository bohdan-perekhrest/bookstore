# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :category
  include Pagy::Backend

  def index
    @pagy, @books, @categories = Books::BooksGenerator.new(params, books: @books, categories: @categories).call
  end
end
