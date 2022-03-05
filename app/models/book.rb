# frozen_string_literal: true

class Book < ApplicationRecord
  MIN_PRICE = 0.01
  MIN_PUBLISHED_AT_YEAR = 1900
  NAME_LENGTH = 120
  MATERIALS_LENGTH = 80
  DESCRIPTION_LENGTH = 5..2000
  NUMBER_NEWEST = 3
  COUNT_BEST_SELLERS = 4

  has_one_attached :image
  has_many_attached :small_images
  belongs_to :category
  has_many :authors_books, dependent: :delete_all
  has_many :authors, through: :authors_books
  has_many :reviews, dependent: :delete_all
  has_many :order_items, dependent: :delete_all
  has_many :orders

  validates :name, :description, :height, :width, :depth, :materials, :price, :published_at, :image, presence: true
  validates :price, numericality: { minimum: MIN_PRICE }
  validates :height, :width, :depth, numericality: { only_float: true }
  validates :small_images, length: { is: 3, message: t('validation.small_images') }
  validates :published_at, numericality: { greater_than_or_equal_to: MIN_PUBLISHED_AT_YEAR, less_than_or_equal_to: Time.zone.now.year }
  validates :name, length: { maximum: NAME_LENGTH }
  validates :materials, length: { maximum: MATERIALS_LENGTH }
  validates :description, length: { in: DESCRIPTION_LENGTH }

  scope :newest, -> { limit(NUMBER_NEWEST).order('id desc') }

  def self.best_sellers(count = COUNT_BEST_SELLERS)
    all.group_by { |book| book.order_items.map(&:quantity).sum }
    .max_by(count) { |key, _value| key }.transpose[1].flatten.limit(count)
  end
end
