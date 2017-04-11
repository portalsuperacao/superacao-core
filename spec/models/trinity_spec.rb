require 'rails_helper'

RSpec.describe Trinity, type: :model do
  subject { described_class.new }

  it "should have all participants" do
    expect(subject).to_not be_valid
    expect(subject.errors.details[:overcomer].first[:error]).to be :blank
    expect(subject.errors.details[:angel].first[:error]).to be :blank
    expect(subject.errors.details[:archangel].first[:error]).to be :blank
  end

  it "should allow a unique Trinity per Overcomer" do
    overcomer = create(:overcomer)

    Trinity.create(overcomer: overcomer,
    angel: create(:angel),
    archangel: create(:archangel))

    subject.overcomer = overcomer
    subject.angel = create(:angel)
    subject.archangel = create(:archangel)

    expect(subject).to_not be_valid
    expect(subject.errors[:trinity].any?).to be true
  end

  it "should not allow more trinites than allowed by the Angel " do
    angel = create(:angel)

    (1..angel.angel_config.supported_overcomers).each do |i|
      Trinity.create(overcomer: create(:overcomer),
                     angel: angel,
                     archangel: create(:archangel))
    end

    subject.overcomer = create(:overcomer)
    subject.angel = angel
    subject.archangel = create(:archangel)

    expect(subject).to_not be_valid
    expect(subject.errors[:trinity].any?).to be true
  end
end
