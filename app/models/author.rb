# frozen_string_literal: true

class Author < ApplicationRecord
  has_many :authors_books, dependent: :delete_all
  has_many :books, through: :authors_books
end
