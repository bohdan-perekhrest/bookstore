# frozen_string_literal: true

class Coupon < ApplicationRecord
  CODE_LENGTH = 15

  has_many :orders

  validates :code, :value, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: CODE_LENGTH }
  validates :value, numericality: { only_float: true }
end
