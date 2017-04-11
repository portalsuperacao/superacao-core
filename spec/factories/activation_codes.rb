FactoryGirl.define do
  factory :activation_code do
    code "MyString"
    activated false
    activated_at "2016-08-18"
  end
end
