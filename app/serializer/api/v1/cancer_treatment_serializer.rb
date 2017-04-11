class Api::V1::CancerTreatmentSerializer < BaseSerializer
  attributes :name
  belongs_to :cancerous, polymorphic: true

  def name
    object.cancer_type.name
  end
end
