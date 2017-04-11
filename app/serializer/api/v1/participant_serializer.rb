class Api::V1::ParticipantSerializer < BaseSerializer
  attributes :cancer_status
  
  has_one :participant_profile
  has_one :current_treatment_profile, serializer: Api::V1::CurrentTreatmentProfileSerializer
  has_one :past_treatment_profile, serializer: Api::V1::PastTreatmentProfileSerializer
end
