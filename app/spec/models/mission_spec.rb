require 'rails_helper'

describe Mission, type: :model do
  it "has a deadline date" do
    mission_type = create(:mission_type)
    trinity = create(:trinity)
    mission = Mission.create!(mission_type: mission_type,
                              trinity: trinity,
                              participant: trinity.overcomer)

    expect(mission.deadline_date-mission.created_at.to_date).to(eq(mission_type.deadline))
  end
end
