class Api::V1::AngelSerializer < Api::V1::ParticipantSerializer
  attribute :uid
  has_many :trinities
end
