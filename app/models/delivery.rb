# frozen_string_literal: true

class Delivery < ApplicationRecord
  has_many :orders, dependent: :nothing

  validates :name, :duration, :price, presence: true
  validates :price, numericality: { minimum: 0.01 }
  validates :name, length: { in: 3..100 }
end
