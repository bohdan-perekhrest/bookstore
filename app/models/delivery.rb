# frozen_string_literal: true

class Delivery < ApplicationRecord
  MIN_PRICE = 0.01
  NAME_LENGTH = 3..100

  has_many :orders, dependent: :nothing

  validates :name, :duration, :price, presence: true
  validates :price, numericality: { minimum: MIN_PRICE }
  validates :name, length: { in: NAME_LENGTH }
end
