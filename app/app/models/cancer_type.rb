# == Schema Information
#
# Table name: cancer_types
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CancerType < ApplicationRecord
  belongs_to :cancer_treatment
end
