class Api::V1::OvercomerSerializer < Api::V1::ParticipantSerializer
  attribute :uid
  has_one :trinity
end
