FactoryBot.define do
  factory :order_item do
    transient do
      book
    end
    order
    quantity { 1 }

    factory :order_item_with_delivered_book do
      before(:create) do |order_item, evaluator|
        order_item.book= evaluator.book if evaluator.book
        order_item.order= FactoryBot.create(:order, :delivered)
      end
    end
    
    trait :with_book do
      before(:create) do |item, evaluator|
        item.book = evaluator.book
        item.save!
      end
    end
  end
end
