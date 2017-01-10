FactoryGirl.define do
  factory :angel do
    name Faker::Name.first_name
    sequence(:uid, 1) { |n| "angel_#{n}" }
  end
end
