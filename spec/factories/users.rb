FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User name #{n}" }
    sequence(:email) { |n| "username#{n}@example.com" }
    password '12345678'
  end
end
