# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :books, dependent: :delete_all
end
