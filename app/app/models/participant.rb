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
  validates :uid, uniqueness: true, allow_nil: false

  has_one :activation_code

  after_create :generate_activation_code

  private
    def generate_activation_code
      ActivationCode.create(participant:self)
    end
end
