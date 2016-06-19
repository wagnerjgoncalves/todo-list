FactoryGirl.define do
  factory :task do
    sequence(:description) { |n| "Task description #{n}" }
  end
end
