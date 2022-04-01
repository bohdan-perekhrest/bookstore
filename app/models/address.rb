# frozen_string_literal: true

class Address < ApplicationRecord
  ZIP_LENGTH = 10
  MAX_LENGTH = 50

  belongs_to :user, optional: true
  belongs_to :order, optional: true

  enum type: { 'Billing': 0, 'Shipping': 1 }

  validates :first_name, :last_name, :zip, :country, :phone, :address, presence: true
  validates :first_name, :last_name, :country, :city,
            format: { with: /\A[a-zA-Z]{0,50}\z/, message: I18n.t('validation.address.flccf_format') }
  validates :address, format: { with: /\A[\w\d\s'-]{0,50}\z/, message: I18n.t('validation.address.address') }
  validates :zip, format: { with: /\A[0-9-]{0,10}\z/, message: I18n.t('validation.address.zip') }
  validates :first_name, :last_name, :country, :city, :address,
            length: { maximum: MAX_LENGTH, message: I18n.t('validation.address.flccf_length') }
  validates :zip, length: { maximum: ZIP_LENGTH, message: I18n.t('validation.address.zip_length') }
  validates :phone, phone: true

  before_save :normalize_phone

  private

  def normalize_phone
    self.phone = Phonelib.parse(phone).full_e164.presence
  end
end
