# == Schema Information
#
# Table name: mission_types
#
#  id       :integer          not null, primary key
#  name     :string(255)
#  deadline :integer
#  guidance :json
#

class MissionType < ApplicationRecord
  has_many :missions
end
