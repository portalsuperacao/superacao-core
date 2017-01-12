require 'faker'

FactoryGirl.define do
  factory :angel do
    name {Faker::Name.name}
    uid "#{Faker::Number.number(5)}_a"
  end
end
