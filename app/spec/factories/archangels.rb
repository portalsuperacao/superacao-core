require 'faker'

FactoryGirl.define do
  factory :archangel do
    name {Faker::Name.name}
    uid "#{Faker::Number.number(5)}_ar"
  end
end
