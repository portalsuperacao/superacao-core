class Api::V1::TreatmentTypesController < BaseController

  def index
    render json: TreatmentType.all, include: [:name]
  end
end
