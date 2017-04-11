class Api::V1::ArchangelSerializer < Api::V1::ParticipantSerializer
  attribute :uid
  has_many :trinities
end
