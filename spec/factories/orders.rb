# frozen_string_literal: true
   
FactoryBot.define do
  factory :order do
    subtotal { 1 }
    total { 1 }
    user
    delivery
    credit_card_id { nil }

    trait :in_progress do
      after(:create) do |order|
        order.status = :in_progress
        order.save!
      end
    end

    trait :delivered do
      after(:create) do |order|
        order.status = :delivered
        order.save!
      end
    end

    trait :in_queue do
      after(:create) do |order|
        order.status = :in_queue
        order.save!
      end
    end

    trait :with_order_item do
      after(:create) do |order|
        order.order_items = FactoryBot.create_list(:order_item, 2)
        order.save!
      end
    end
  end
end
