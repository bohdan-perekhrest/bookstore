# frozen_string_literal: true

class Book < ApplicationRecord
  has_one_attached :image
  has_many_attached :small_images
  belongs_to :category
  has_many :authors_books, dependent: :delete_all
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :delete_all
  has_many :order_items, dependent: :delete_all
  has_many :orders

  validates :name, :description, :height, :width, :depth, :materials, :price, :published_at, :image presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :height, :width, :depth, numericality: { only_float: true }
  validates :published_at, numericality: { greater_than_or_equal_to: 1900, less_than_or_equal_to: Time.zone.now.year }
  validates :name, length: { maximum: 120 }
  validates :materials, length: { maximum: 80 }
  validates :description, length: { in: 5..2000 }

  scope :newest, -> { last(3) }
  scope :best_sellers, lambda { |count = 4|
    all.group_by { |book| book.order_items.map(&:quantity).sum }
       .max_by(count) { |key, _value| key }.transpose[1].flatten.first(count)
  }
end
