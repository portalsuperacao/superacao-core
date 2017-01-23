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

class Angel < Participant
  has_many :trinities
  has_one :angel_config
end
