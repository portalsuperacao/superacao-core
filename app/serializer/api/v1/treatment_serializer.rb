class Api::V1::TreatmentSerializer < BaseSerializer
  attributes :status, :name

  belongs_to :treatable, polymorphic: true

  def name
    object.treatment_type.name
  end
end
