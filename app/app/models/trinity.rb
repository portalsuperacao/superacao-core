# == Schema Information
#
# Table name: trinities
#
#  id             :integer          not null, primary key
#  participant_id :integer
#  angel_id       :integer
#  archangel_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Trinity < ApplicationRecord
  belongs_to :overcomer
  belongs_to :angel
  belongs_to :archangel
end
