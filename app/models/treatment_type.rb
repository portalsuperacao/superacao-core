# == Schema Information
#
# Table name: treatment_types
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TreatmentType < ApplicationRecord
  has_many :treatments
end
