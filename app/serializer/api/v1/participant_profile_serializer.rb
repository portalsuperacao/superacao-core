class Api::V1::ParticipantProfileSerializer < BaseSerializer
  attributes :first_name, :last_name

  belongs_to :participant
end
