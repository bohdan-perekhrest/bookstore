# frozen_string_literal: true

class Address < ApplicationRecord
  ZIP_LENGTH = 10
  MAX_LENGTH = 50

  belongs_to :user, optional: true
  belongs_to :order, optional: true

  enum type: { billing: 0, shipping: 1 }

  validates :first_name, :last_name, :zip, :country, :phone, :address, presence: true
  validates :first_name, :last_name, :country, :city, format: { with: /\A[a-zA-Z]{0,50}\z/ }
  validates :address, format: { with: /\A[\w\d\s'-]{0,50}\z/ }
  validates :zip, format: { with: /\A[0-9-]{0,10}\z/ }
  validates :first_name, :last_name, :country, :city, :address, length: { maximum: MAX_LENGTH }
  validates :zip, length: { maximum: ZIP_LENGTH }
end
