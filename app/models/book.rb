# frozen_string_literal: true

class Book < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :category
end
