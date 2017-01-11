class TrinitiesController < BaseController

  def index
    render json: Trinity.all.page(params[:page])
  end

  def custom_match
    params.require(:trinity).permit(:overcomer, :angel, :archangel)

    trinity = Trinity.new(overcomer_id: params[:trinity][:overcomer],
                          angel_id: params[:trinity][:angel],
                          archangel_id: params[:trinity][:archangel])

    if trinity.valid?
      TrinitiesService.create_custom_match(trinity)
      render json: trinity, status: 201
    else
      return api_error(status: 422, errors: trinity.errors)
    end
  end

end
