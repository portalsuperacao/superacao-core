# == Schema Information
#
# Table name: missions
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  deadline   :integer          not null
#  guidance   :json {"angel"=>"",
#                    "archangel" =>"",
#                    "overcomer" =>"" }

class MissionType < ApplicationRecord

  def missions
    Mission.where(mission_type_id: self.id)
  end
end
