class Api::V1::TreatmentProfileSerializer < BaseSerializer
  attributes :pacient, :metastasis, :relapse

  belongs_to :participant
  has_many :treatments, as: :treatable, polymorphic: true
  has_many :cancer_treatments, as: :cancerous
end
