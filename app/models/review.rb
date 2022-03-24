# frozen_string_literal: true

class Review < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :book

  enum status: { unproccessed: 0, approved: 1, rejected: 2 }

  aasm column: :status, enum: true do
    state :unproccessed, initial: true
    state :approved
    state :rejected

    event :approve do
      transitions from: :unproccessed, to: :approved
    end

    event :reject do
      transitions from: :unproccessed, to: :rejected
    end
  end

  validates :title, :text, :star, :status, presence: true
  validates :title, :text, format: { with: %r{[\w\d\s]+[-!#$%&'*+/=?^_`{|}~.,]?} }
  validates :title, length: { maximum: 80 }
  validates :text, length: { maximum: 500 }
end
