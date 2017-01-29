FactoryGirl.define do
  factory :participant do
    participant_profile

    factory :overcomer, class: Overcomer do
      sequence(:uid, 1) { |n| "overcomer_#{n}" }
    end

    factory :angel, class: Angel do
      sequence(:uid, 1) { |n| "angel_#{n}" }
    end

    factory :archangel, class: Archangel do
      sequence(:uid, 1) { |n| "archangel_#{n}" }
    end
  end
end
