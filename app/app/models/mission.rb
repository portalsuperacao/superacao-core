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
  belongs_to :mission_type
  belongs_to :trinity
  belongs_to :owner, class_name: "Participant", foreign_key: "participant_id"


  def deadline_date
    self.created_at + self.mission_type.deadline.days
  end

  def mission_type
    MissionType.find(self.mission_type_id)
  end
end
