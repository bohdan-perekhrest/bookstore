# frozen_string_literal: true

class GenerateCatalog < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    generate_catalog
  end

  private

  def generate_catalog
    pagy, books = BookService::GenerateBooks.new(@params).call
    categories = generate_categories
    [pagy, books, categories]
  end

  def generate_categories
    Category.with_books_count
  end
end
