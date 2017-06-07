# == Schema Information
#
# Table name: participants
#
#  id                  :integer          not null, primary key
#  uid                 :string
#  type                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  pacient             :integer
#  cancer_status       :integer
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  family_member       :string
#

class Angel < Participant
  has_many :trinities
  has_one :angel_config

  before_create :build_config

  accepts_nested_attributes_for :angel_config

  scope :available_trinities, -> {
     joins(:participant_profile,:trinities )
    .group(:id,'"participant_profiles"."first_name"')
    .having('count(*) < (SELECT "angel_configs"."supported_overcomers"
                         FROM "angel_configs"
                         WHERE "angel_configs"."angel_id" = "participants"."id" )')
    .order('"participant_profiles"."first_name"')
  }

  def accepts_one_trinity?
    self.trinities.count < self.angel_config.supported_overcomers
  end

  private
    def build_config
        build_angel_config
    end
end
