# frozen_string_literal: true

class Delivery < ApplicationRecord
  has_many :orders

  validates :name, :duration, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, length: { in: 3..100 }
end
