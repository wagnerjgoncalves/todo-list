FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User name #{n}" }
    sequence(:email) { |n| "username#{n}@example.com" }
    password '12345678'

    trait :auth do
      email 'user@example.com'
    end
  end
end
