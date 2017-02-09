# == Schema Information
#
# Table name: participants
#
#  id            :integer          not null, primary key
#  uid           :string
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  pacient       :integer
#  cancer_status :integer
#

class Archangel < Participant
  has_many :trinities
  has_many :angels, through: :trinity

  MAX_TRINITIES = Rails.configuration.superacao['archangel_max_trinities']

  scope :available_trinities, -> {
     joins(:participant_profile, :trinities)
    .group(:id,'"participant_profiles"."first_name"')
    .having("count(*) < #{MAX_TRINITIES}")
    .order('"participant_profiles"."first_name"')
  }
end
