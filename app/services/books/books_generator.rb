# frozen_string_literal: true

module BookService
  class BooksGenerator < ApplicationService
    def initialize(params, books:, categories:)
      @params = params
      @books = books
      @categories = categories
    end

    def call
      generate_catalog
    end

    private

    attr_reader :params

    def generate_catalog
      pagy, books = generate_books
      categories = generate_categories
      [pagy, books, categories]
    end

    def generate_categories
      @categories.joins(:books).select('categories.*, count(books.id) as books_count').group('categories.id')
    end

    def generate_books
      by_category if category_id
      by_filter if filter
      pagination
    end

    def by_category
      @books = @books.where(category_id: category_id)
    end

    def by_filter
      @books = BooksQuery.new(@books).by_filter(filter)
    end

    def set_books
      @books.each_slice(4).to_a
    end

    def pagination
      @pagy, @books = pagy(@books, page: page)
      @books = set_books
      [@pagy, @books]
    end

    def category_id
      @params[:category_id]
    end

    def page
      @params[:page] || 1
    end

    def filter
      @params[:filter]
    end
  end
end
