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

class Participant < ApplicationRecord
  include PgSearch
  extend Enumerize

  alias_attribute :profile, :participant_profile

  enumerize :pacient, in: [:pacient, :family_member]
  enumerize :family_member, in: [:son, :father, :mother, :brother, :sister, :cousin, :uncle,
                      :grandmother, :grandfather, :aunt]
  enumerize :cancer_status, in: [:overcome, :during_treatment]

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" },
                     default_url: lambda { |attach| "/images/:style/#{attach.instance.participant_profile.genre}_participant.png"}
  validates :uid, uniqueness: true, allow_nil: false, if: 'uid.present?'
  validates :family_member, presence: true, allow_nil: false, if: 'family_member.present?'
  validates :pacient, :cancer_status, presence: true

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_one :activation_code, dependent: :destroy
  has_one :participant_profile, dependent: :destroy
  has_one :current_treatment_profile, class_name: 'TreatmentProfile', foreign_key: 'current_participant_id', dependent: :destroy
  has_one :past_treatment_profile, class_name: 'TreatmentProfile', foreign_key: 'past_participant_id', dependent: :destroy
  has_many :missions, dependent: :destroy

  pg_search_scope :search_by_full_name,
                  :associated_against => {
                    :participant_profile => [:first_name, :last_name]},
                  :using => {:tsearch => {:prefix => true}}

  after_create :generate_activation_code

  accepts_nested_attributes_for :participant_profile, :current_treatment_profile,
                                :past_treatment_profile

  scope :overcomers, -> { where(type: 'Overcomer') }
  scope :angels, -> { where(type: 'Angel') }
  scope :archangels, -> { where(type: 'Archangel') }

  def is_overcomer_and_has_no_trinity
    self.is_a? Overcomer and !active_trinities.any?
  end

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
