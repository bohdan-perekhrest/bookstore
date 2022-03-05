# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :coupon, optional: true
  belongs_to :delivery, optional: true
  belongs_to :credit_card, optional: true
  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items
  has_many :addresses, dependent: :destroy
  has_one :billing
  has_one :shipping

  enum status: { in_progress: 0, in_queue: 1, in_delivery: 2, delivered: 3, canceled: 4 }

  validates :status, presence: true
  scope :proccesing_order, -> { where(status: :in_queue).order('updated_at').last }

  before_validation :order_status, on: :create
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

  def finalize
    order_status(:in_queue)
    save!
  end

  private

  def order_status(status = :in_progress)
    self[:status] = status
  end

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
