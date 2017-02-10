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
  has_many :missions

  enum status: { active: 0, archived: 1 }

  validates :overcomer, :angel, :archangel, presence: true
  validate :single_trinity_per_overcomer
  validate :max_trinities_per_angel, unless: -> { self.angel.blank? }

  private
    def single_trinity_per_overcomer
        if Trinity.exists?(status: :active,
                        overcomer_id: self.overcomer_id)
          errors.add(:trinity, "Superador já possui um trio.")
        end
    end

    def max_trinities_per_angel
        unless self.angel.accepts_one_trinity?
          errors.add(:trinity, "Anjo já atingiu limite de Superadores.")
        end
    end
end
