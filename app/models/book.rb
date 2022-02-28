# frozen_string_literal: true

class Book < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :category
  has_many :authors_books, dependent: :destroy
  has_many :authors, through: :authors_books
  has_many :reviews
  has_many :order_items

  validates :name, :description, :height, :width, :depth, :materials, :price, :published_at, presence: true
  validates :price, numericality: { minimum: 0.01 }
  validates :height, :width, :depth, numericality: { only_float: true }
  validates :published_at, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.now.year }
  validates :name, uniqueness: true
  validates :name, length: { maximum: 120 }
  validates :materials, length: { maximum: 80 }
  validates :description, length: { in: 5...2000 }

  scope :newest, -> { last(3) }
  scope :best_sellers, -> (count = 4) { all.group_by{ |book| book.order_items.map(&:quantity).sum }
    .max_by(count){ |key, value| key }.transpose[1].flatten.first(count) 
  }
end
