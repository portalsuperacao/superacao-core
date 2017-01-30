# == Schema Information
#
# Table name: missions
#
#  id              :integer          not null, primary key
#  mission_type_id :integer
#  trinity_id      :integer
#  participant_id  :integer
#  status          :string           default("new"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Mission < ApplicationRecord
  alias_attribute :owner, :participant

  belongs_to :mission_type
  belongs_to :trinity
  belongs_to :participant

  def deadline_date
    self.created_at.to_date + self.mission_type.deadline.days
  end
end
