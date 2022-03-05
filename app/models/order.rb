# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  has_many :order_items, dependent: :delete_all
  has_many :books, through: :order_items
  has_many :addresses, dependent: :destroy
  has_one :billing, dependent: :delete_all
  has_one :shipping, dependent: :delete_all

  enum status: { in_progress: 0, in_queue: 1, in_delivery: 2, delivered: 3, canceled: 4 }

  aasm column: :status, enum: true do
    state :in_progress, initial: true
    state :in_queue
    state :in_delivery
    state :delivered
    state :canceled

    event :in_queue do
      transitions from: :in_progress, to: :in_queue
    end

    event :in_delivery do
      transitions from: :in_queue, to: :in_delivery
    end

    event :deliver do
      transitions from: :in_delivery, to: :delivered
    end

    event :cancel do
      transitions from: %i[in_queue in_delivery], to: :canceled
    end
  end

  before_save :update_subtotal, :update_total

  def subtotal
    order_items.sum(&:total_price)
  end

  def total
    subtotal - discount + delivery_price
  end

  def discount
    coupon.try(:value) || 0.00
  end

  def delivery_price
    delivery.try(:price) || 0.00
  end

  def finalize
    in_queue!
    save!
  end

  def self.proccesing_order
    in_queue.order('updated_at').limit(1)
  end

  private

  def update_subtotal
    assign_attributes(subtotal: subtotal)
  end

  def update_total
    assign_attributes(total: total)
  end
end
