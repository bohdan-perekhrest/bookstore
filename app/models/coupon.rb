# frozen_string_literal: true

class Coupon < ApplicationRecord
  has_many :orders

  validates :code, :value, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 15 }
  validates :value, numericality: { only_float: true }
end
