# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_books = Book.newest.map { |book| BookPresenter.new(book) }
    @best_sellers = Book.best_sellers.map { |book| BookPresenter.new(book) }
  end
end
