# == Schema Information
#
# Table name: trinities
#
#  id           :integer          not null, primary key
#  overcomer_id :integer
#  angel_id     :integer
#  archangel_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Trinity < ApplicationRecord
  belongs_to :overcomer
  belongs_to :angel
  belongs_to :archangel

  before_validation :trinity_constraints

  def missions
    Mission.where(trinity_id: self.id)
  end
  
  private
    def trinity_constraints

    end
end
