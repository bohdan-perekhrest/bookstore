FactoryBot.define do
  factory :review do
    transient do
      status { :unproccessed }
    end

    sequence(:title) { |i| FFaker::Book.title + i.to_s }
    star { 5 }
    text { 'review context' }
    user
    book

    before(:create) do |review, evaluator|
      review.status= evaluator.status
    end

    trait :with_user do
      before(:create) do |review|
        review.user = create(:user)
      end
    end
  end
end
