FactoryBot.define do
  factory :coupon do
    transient do
      value { 9.99 }
      code { 'D12345678900000' }
    end

    before(:create) do |coupon, evaluator|
      coupon.value= evaluator.value
      coupon.code= evaluator.code
    end
  end
end
