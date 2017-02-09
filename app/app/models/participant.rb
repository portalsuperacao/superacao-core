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

class Participant < ApplicationRecord
  include PgSearch

  alias_attribute :profile, :participant_profile
  enum pacient: [:myself, :family_member]
  enum cancer_status: [:overcome, :during_treatment]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                     default_url: lambda { |attach| "/images/:style/#{attach.instance.participant_profile.genre}_participant.png"}
  validates :uid, uniqueness: true, allow_nil: false, if: 'uid.present?'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_one :activation_code
  has_one :participant_profile
  has_one :current_treatment_profile, class_name: 'TreatmentProfile', foreign_key: 'current_participant_id'
  has_one :past_treatment_profile, class_name: 'TreatmentProfile', foreign_key: 'past_participant_id'
  has_many :missions

  pg_search_scope :search_by_full_name,
                  :associated_against => {
                    :participant_profile => [:first_name, :last_name]},
                  :using => {:tsearch => {:prefix => true}}

  after_create :generate_activation_code

  def active_trinities
     Trinity.where("#{self.type.downcase.to_sym}":  self.id, status: :active)
  end

  def name
    self.profile.name
  end

  private
    def generate_activation_code
      ActivationCode.create(participant:self)
    end
end
