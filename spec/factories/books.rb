require 'ffaker'
include ActionDispatch::TestProcess

FactoryBot.define do
  factory :book do
    transient do
      cost { 555.55 }
      category_name { FactoryBot.create(:category).id }
    end

    price { 1.0 }
    sequence(:name)  { |i| FFaker::Book.title + i.to_s }
    description { FFaker::Book.description }
    published_at { 2015 }
    height { 1.1 }
    width { 2.0 }
    depth { 0.8 }
    materials { 'paper, silk' }
    category

    before(:create) do |book, evaluator|
      book.category_id= (Category.find_by_name(evaluator.category_name) ||
        FactoryBot.create(:category, name: evaluator.category_name)).id
    end

    before(:create) do |book|
      book.image.attach(io: File.open('spec/support/assets/for_test.png'), filename: 'for_test.png', content_type: 'image/png') 
    end

    after(:create) do |book, evaluator|
      book.price= evaluator.cost
    end

    trait :with_authors do 
      before(:create) do |book|
        book.authors << create_list(:author, 3)
      end
    end
  end
end
