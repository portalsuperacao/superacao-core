# == Schema Information
#
# Table name: activation_codes
#
#  id             :integer          not null, primary key
#  code           :string
#  activated      :boolean
#  activated_at   :date
#  participant_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class ActivationCode < ApplicationRecord
  before_validation :generate_code
  belongs_to :participant

  validates :code, uniqueness: true

   private
    def generate_code
        self.code = create_code

        while ActivationCode.find_by_code(self.code)
          self.code = create_code
        end
    end

    def create_code
      (0...8).map { (65 + rand(26)).chr }.join
    end
end
