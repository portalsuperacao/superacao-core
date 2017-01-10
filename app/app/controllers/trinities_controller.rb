class TrinitiesController < BaseController

  def index
    render json: Trinity.all.page(params[:page])
  end

  def custom_match
    params.require(:trinity).permit(:overcomer, :angel, :archangel)
    t = params[:trinity]

    trinity = Trinity.new(overcomer_id: t[:overcomer],
                          angel_id: t[:angel],
                          archangel_id: t[:archangel])

    if trinity.valid?
      if trinity.save
        render text: "OK"
      end
    else
      return api_error(status: 422, errors: trinity.errors)
    end
    # TrinitiesService.create_manual_match(params)
  end

end
