# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Alex"
    last_name "Mitchell"
    sequence(:email) { |n| "alex#{n}@example.com" }
    password "password"
  end
end
