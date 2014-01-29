FactoryGirl.define do
  factory :company do
    sequence(:id)
    trait :good_request_company do
      name "company1"
      description "company"
    end
    trait :empty_request do
      name ""
      description ""
    end
    factory :bad_company ,traits: [:empty_request]
    factory :good_company ,traits: [:good_request_company]
  end
end
