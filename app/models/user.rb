# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  attr_accessor :skip_password_validation

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :orders, dependent: :delete_all
  has_many :reviews, dependent: :delete_all
  has_many :addresses, dependent: :delete_all
  has_one :billing, dependent: :delete_all
  has_one :shipping, dependent: :delete_all

  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)\S{8,}\z/ }, unless :skip_password_validation

  def self.new_with_session(params, session)
    super.tap do |user|
      if (data = session['devise.facebook_data'] &&
          session['devise.facebook_data']['extra']['raw_info']) && user.email.blank?
        user.email = data['email']
      end
    end
  end
  
  def order_in_progress
    orders.where(status: 'in_progress').first
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  private

  def password_required?
    return false if skip_password_validation

    super
  end
end
