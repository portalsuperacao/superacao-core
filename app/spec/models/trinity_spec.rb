require 'rails_helper'

RSpec.describe Trinity, type: :model do
  subject { described_class.new }
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
end
