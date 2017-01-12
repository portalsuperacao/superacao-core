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
#  status       :integer          default("active")
#

class Trinity < ApplicationRecord
  belongs_to :overcomer
  belongs_to :angel
  belongs_to :archangel

  enum status: { active: 0, archived: 1 }

  validate :single_trinity_per_overcomer

  private
    def single_trinity_per_overcomer
        if Trinity.exists?(status: :active,
                        overcomer_id: self.overcomer_id)
          errors.add(:trinity, "Already exists a trinity for this Overcomer.")
        end
    end
end
