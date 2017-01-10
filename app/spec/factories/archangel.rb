FactoryGirl.define do
  factory :archangel do
    name Faker::Name.first_name
    sequence(:uid, 1) { |n| "archangel_#{n}" }
  end
end
