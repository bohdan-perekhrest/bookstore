require 'ffaker'

FactoryBot.define do
  factory :author do
    sequence(:first_name)  { |i| FFaker::Book.author + i.to_s }
    sequence(:last_name) { |i|  FFaker::Book.author + i.to_s }
  end
end
