# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books, dependent: :delete_all

  validates :name, presence: true, uniqueness: true

  scope :with_books_count, lambda {
                             joins(:books).select('categories.*, count(books.id) as books_count').group('categories.id')
                           }
end
