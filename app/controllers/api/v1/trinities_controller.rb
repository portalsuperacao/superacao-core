class Api::V1::TrinitiesController < BaseController

  def index
    render json: Trinity.all.page(params[:page])
  end

  def new
    @participant = Participant.find(params[:participant_id])
    @angels = Angel.available_trinities
    @archangels = Archangel.available_trinities

    respond_to do |format|
       format.js
     end
  end

  def custom_match
    trinity = Trinity.new(params.require(:trinity).permit(:overcomer_id, :angel_id, :archangel_id))

    if trinity.valid?
      TrinitiesService.create_custom_match(trinity)
      flash[:success] = "Trio criado com sucesso."
    else
      flash[:error] = "Falha ao criar o trio. "
    end
    flash.keep
    render js: "window.location = '#{participant_path(trinity.overcomer)}'"
  end

  def match
    render json: Angel.all.sample, include: 'participant_profile,current_treatment_profile,current_treatment_profile.treatments,current_treatment_profile.cancer_treatments,past_treatment_profile.treatments,past_treatment_profile.cancer_treatments'
  end
end
