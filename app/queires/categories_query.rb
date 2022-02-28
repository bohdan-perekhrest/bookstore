# frozen_string_literal: true

class CategoriesQuery
  def call
    generate_categories
  end

  private

  def generate_categories
    Category.joins(:books).select('categories.*, count(books.id) as books_count').group('categories.id')
  end
end
