# frozen_string_literal: true

class CatalogGenerator < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    generate_catalog
  end

  private

  def generate_catalog
    pagy, books = BookService::BooksGenerator.new(@params).call
    categories = generate_categories
    [pagy, books, categories]
  end

  def generate_categories
    Category.joins(:books).select('categories.*, count(books.id) as books_count').group('categories.id')
  end
end
