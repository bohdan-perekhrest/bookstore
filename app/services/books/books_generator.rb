# frozen_string_literal: true

module BookService
  class BooksGenerator < ApplicationService
    def initialize(params, books:)
      @params = params
      @books = books
    end

    def call
      pagy(@books, page: page)
    end

    private

    attr_reader :params

    def generate_books
      by_category if category_id
      by_filter if filter
    end

    def by_category
      @books = BooksQuery.new(@books).by_category(category_id)
    end

    def by_filter
      @books = BooksQuery.new(@books).by_filter(filter)
    end

    def category_id
      params[:category_id]
    end

    def page
      params[:page] || 1
    end

    def filter
      params[:filter]
    end
  end
end
