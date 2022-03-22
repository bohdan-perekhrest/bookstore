# frozen_string_literal: true

class Book < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
end
