# frozen_string_literal: true

class OrderItem < ApplicationRecord
  MIN_QUANTITY = 1

  belongs_to :book
  belongs_to :order

  validates :total_price, :quantity, presence: true
  validates :quantity, numericality: { only_integer: true, minimum: MIN_QUANTITY }

  before_save :finilize

  def total_price
    quantity * book.price
  end

  private

  def finilize
    assign_attributes(total_price: total_price)
  end
end
