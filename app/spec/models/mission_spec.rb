require 'rails_helper'

RSpec.describe Mission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "has a deadline date" do
    mission_type = create(:mission_type)
    trinity = create(:trinity)
    mission = Mission.create!(mission_type: mission_type, trinity: trinity, owner: trinity.overcomer)

    expect(mission.deadline_date-mission.created_at.to_date).to(eq(mission_type.deadline))
  end
end
