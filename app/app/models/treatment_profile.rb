# == Schema Information
#
# Table name: treatment_profiles
#
#  id             :integer          not null, primary key
#  pacient        :integer
#  participant_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class TreatmentProfile < ApplicationRecord
  enum pacient: [:myself, :family_member]

  belongs_to :participant
  has_many :cancer_treatments, as: :cancerous
end
