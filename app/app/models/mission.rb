# == Schema Information
#
# Table name: missions
#
#  id               :integer          not null, primary key
#  mission_type_id  :integer not null, foreign key
#  trinity_id       :integer not null, foreign key
#  status           :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#



class Mission < ApplicationRecord
  has_one :mission_type
  attr_accessor :deadline_date
  after_create :set_deadline_date

  def set_deadline_date
    self.deadline_date = self.mission_type.deadline.days.from_now
  end

  def mission_type
    MissionType.find(self.mission_type_id)
  end
end
