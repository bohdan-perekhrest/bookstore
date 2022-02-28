# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :book
  belongs_to :order, dependent: :destroy

  validates :total_price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, minimum: 1 }

  before_save :finilize

  def total_price
    quantity * book.price
  end

  private

  def finilize
    self[:total_price] = total_price
  end
end
