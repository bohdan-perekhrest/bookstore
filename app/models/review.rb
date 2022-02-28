# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user, dependent: :destroy
  belongs_to :book, dependent: :destroy

  validates :title, :text, :star, :status, presence: true
  validates :title, :text, format: { with: %r{[\w\d\s]+[-!#$%&'*+/=?^_`{|}~.,]?} }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 500 }
  validates :status, acceptance: { accept: %w[approved rejected unprocessed] }

  scope :approved, -> { where(status: 'approved').order(created_at: :desc) }

  before_save :status

  private

  def status(status = 'unprocessed')
    self[:status] = status
  end
end
