# frozen_string_literal: true

module BookService
  class GenerateBooks < ApplicationService

    attr_reader :params

    def initialize(params)
      @params = params
      @books = Book.all
    end

    def call
      generate_books
    end

    private

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
