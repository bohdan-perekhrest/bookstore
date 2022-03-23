# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :title, :text, :star, :status, presence: true
  validates :title, :text, format: { with: %r{[\w\d\s]+[-!#$%&'*+/=?^_`{|}~.,]?} }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 500 }
  validates :status, acceptance: { accept: %w[approved rejected unprocessed] }
end
