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

class Overcomer < Participant
  has_one :trinity

  def trinities
    [self.trinity]
  end

end
