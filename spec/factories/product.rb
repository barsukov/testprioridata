FactoryGirl.define do
  factory :product do
    sequence(:id)
    trait :good_request_product do
      name "product1"
    end
    trait :empty_request do
      name ""
    end
    factory :bad_product ,traits: [:empty_request]
    factory :good_product ,traits: [:good_request_product]
  end
end
