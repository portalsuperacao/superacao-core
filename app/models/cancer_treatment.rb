# == Schema Information
#
# Table name: cancer_treatments
#
#  id             :integer          not null, primary key
#  cancer_type_id :integer
#  cancerous_type :string
#  cancerous_id   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class CancerTreatment < ApplicationRecord
  belongs_to :cancerous, polymorphic: true
  belongs_to :cancer_type
end
