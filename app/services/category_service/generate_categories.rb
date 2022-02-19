# frozen_string_literal: true

module CategoryService
  class GenerateCategories < ApplicationService
    def call
      generate_categories
    end
   
   def generate_categories 
      Category.joins(:books).select('categories.*, count(books.id) as books_count').group('categories.id')
    end
  end
end
