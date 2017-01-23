# == Schema Information
#
# Table name: participants
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  uid        :string(255)
#  type       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participant < ApplicationRecord
  alias_attribute :profile, :participant_profile
  validates :uid, uniqueness: true, allow_nil: false, if: 'uid.present?'

  has_one :activation_code
  has_one :participant_profile
  has_one :treatment_profile
  has_many :missions

  after_create :generate_activation_code

  def name
    self.profile.name
  end

  private
    def generate_activation_code
      ActivationCode.create(participant:self)
    end
end
