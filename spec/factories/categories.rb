# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    transient do
      type { FFaker::Lorem.phrase }
    end

    sequence(:name) { |i| FFaker::Lorem.phrase + i.to_s }

    after(:create) do |category, evaluator|
      category.name= evaluator.type
      category.save
    end

    trait :with_books_web do
      after(:create) do |category|
        category.books << create_list(:book, 8, category_id: category.id)
      end
    end

    trait :with_books_mobile do
      after(:create) do |category|
        category.books << create_list(:book, 15, category_id: category.id)
      end
    end
  end
end
