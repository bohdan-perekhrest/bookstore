# frozen_string_literal: true

FactoryBot.define do
  ADDRESSES_TYPE = %w[Billing Shipping]

  factory :address do
    type { ADDRESSES_TYPE.sample }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.html_safe_last_name }
    address { FFaker::AddressUS.street_address.gsub(/[\W_]/, '') }
    city { FFaker::AddressUS.city.gsub(/[\W_]/, '') }
    zip { FFaker::AddressUS.zip_code }
    country { FFaker::AddressUS.country.gsub(/[\W_]/, '') }
    phone { '0994784151' }
    user
    order
  end

  trait :with_user do
    before(:create) do |address|
      address.user = create(:user)
    end
  end
end
