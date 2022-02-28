# frozen_string_literal: true

class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value); end
end
