# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user
    title "Rocket Ship"
    teaser "Slower than light, faster than a car"
    description "We're building one of those rocketship things"
    goal 1000000000
  end
end
