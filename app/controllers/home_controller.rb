# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @latest_books = Book.newest
    @best_sellers = Book.best_sellers
  end
end
