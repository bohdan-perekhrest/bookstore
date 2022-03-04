# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :book, dependent: :destroy

  enum status: { unproccessed: 0, approved: 1, rejected: 2 }

  validates :title, :text, :star, :status, presence: true
  validates :title, :text, format: { with: %r{[\w\d\s]+[-!#$%&'*=+/?^_`{|}~.,]?} }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 500 }
  validates :star, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5, only_integer: true }

  scope :approved, -> { where(status: :approved).order(created_at: :desc) }
end
