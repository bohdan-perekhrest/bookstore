# frozen_string_literal: true

class CreditCard < ApplicationRecord
  has_one :order, dependent: :nothing

  validates :number, :name, :mm_yy, :cvv, presence: true
  validates :cvv, length: { in: 3..4 }
  validates :cvv, numericality: { only_integer: true }
  validates :mm_yy, format: { with: %r{\A(0[1-9]|10|11|12)/\d\d\z}, message: I18n.t('validation.mm_yy') }
  validates :number, format: { with: /\A\d{16}\z/, message: I18n.t('validation.card_number') }
  validates :name, format: { with: /\A[a-zA-Z\s]{0,49}\z/, message: I18n.t('validation.card_name') }
end
