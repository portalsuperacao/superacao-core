# == Schema Information
#
# Table name: treatments
#
#  id                :integer          not null, primary key
#  status            :integer
#  treatment_type_id :integer
#  treatable_type    :string
#  treatable_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Treatment < ApplicationRecord
  enum status: [:doing, :done]
  belongs_to :treatable, polymorphic: true
  belongs_to :treatment_type
end
