FactoryBot.define do
  factory :order do
    subtotal { 1 }
    total { 1 }
    user
    delivery
    credit_card_id { nil }

    trait :delivered do
      after(:create) do |order|
        order.delivered!
        order.save!
      end
    end

    trait :in_queue do
      after(:create) do |order|
        order.in_queue!
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
