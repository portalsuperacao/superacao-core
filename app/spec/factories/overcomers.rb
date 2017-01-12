require 'faker'

FactoryGirl.define do
  factory :overcomer do
    name {Faker::Name.name}
    uid Faker::Number.number(5)
  end
end
