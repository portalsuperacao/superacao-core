# == Schema Information
#
# Table name: participant_profiles
#
#  id             :integer          not null, primary key
#  first_name     :string(255)
#  last_name      :string(255)
#  birthdate      :date
#  occupation     :string(255)
#  country        :string(255)
#  state          :string(255)
#  city           :string(255)
#  lat            :decimal(10, )
#  lng            :decimal(10, )
#  relationship   :string(255)
#  sons           :integer
#  facebook       :string(255)
#  instagram      :string(255)
#  whatsapp       :string(255)
#  youtube        :string(255)
#  snapchat       :string(255)
#  participant_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ParticipantProfile < ApplicationRecord
end
