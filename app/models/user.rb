# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         # :omiauthable
  validates :email, format: { with: /\A[^-.]\w+[-.]?(\w+[-!#$%&'*+\/=?^_`{|}~.]\w+)*[^-]@([\w\d]+)\.([\w\d]+)\z/ }
  validates :password, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)\S{8,}\z/  }
end
