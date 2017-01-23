# == Schema Information
#
# Table name: treatment_profiles
#
#  id                     :integer          not null, primary key
#  pacient                :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  current_participant_id :integer
#  past_participant_id    :integer
#  metastasis             :boolean
#  relapse                :boolean
#

class TreatmentProfile < ApplicationRecord
  belongs_to :participant
  has_many :treatments, as: :treatable
  has_many :cancer_treatments, as: :cancerous
end
