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

  scope :proccesing_order, -> { where(status: :in_queue).order('updated_at').last }

  before_save :update_subtotal, :update_total, :connect_user

  def subtotal
    order_items.sum(&:total_price)
  end

  def total
    subtotal - discount
  end

  def discount
    coupon.try(:value) || 0.00
  end

  def finilize
    in_queue!
    save!
  end

  private

  def connect_user
    self[:user_id] = CurrentSession.user.id unless CurrentSession.user.nil?
  end

  def update_subtotal
    self[:subtotal] = subtotal
  end

  def update_total
    self[:total] = total
  end
end
