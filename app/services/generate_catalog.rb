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
    categories = CategoriesQuery.new.call
    [pagy, books, categories]
  end
end
