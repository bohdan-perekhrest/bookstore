# frozen_string_literal: true

class Coupon < ApplicationRecord
  has_many :orders

  validates :code, :value, presence: true
  validates :code, uniqueness: true
  validates :value, numericality: { only_float: true }
end
