FactoryGirl.define do
  factory :overcomer do
    name Faker::Name.first_name
    sequence(:uid, 1) { |n| "overcomer_#{n}" }
  end
end
