# frozen_string_literal: true

module FullNameHelper
  def full_name(object)
    "#{object.first_name} #{object.last_name}"
  end

  def city_zip(object)
    "#{object.city} #{object.zip}"
  end
end

