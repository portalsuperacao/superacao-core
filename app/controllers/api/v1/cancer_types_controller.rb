class Api::V1::CancerTypesController < BaseController

  def index
    render json: CancerType.all, include: [:name]
  end
end
