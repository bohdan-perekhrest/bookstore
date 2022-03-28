# frozen_string_literal: true

class Review < ApplicationRecord
  include AASM

  TITLE_LENGTH = 80
  TEXT_LENGTH = 500

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
  validates :title, length: { maximum: TITLE_LENGTH }
  validates :text, length: { maximum: TEXT_LENGTH }
end
