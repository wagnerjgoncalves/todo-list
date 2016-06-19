FactoryGirl.define do
  factory :sub_task do
    sequence(:description) { |n| "Sub Task Description #{n}" }
    completed false
  end
end
