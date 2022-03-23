# frozen_string_literal: true

class BooksController < ApplicationController
  load_and_authorize_resource
  load_and_authorize_resource :categories
  respond_to :html, :js, only: %i[index]
  include Pagy::Backend

  def index
    @pagy, @books = Books::BooksGenerator.new(params, books: @books).call
  end

  def show; end
end
