class ParticipantsController < BaseController
  before_action :authenticate, only: :trinities

  def index
    if params[:type]
      @participants = Participant.where(type: params[:type]).includes(:participant_profile).page(params[:page])
    else
      @participants = Participant.all.includes(:participant_profile).page(params[:page])
    end
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def new
    @participant_profile = ParticipantProfile.new
  end

  def create
    pariticipant_type = params["participant_profile"]["participant_type"]
    participant = Object.const_get(pariticipant_type.capitalize).new
    participant_profile = ParticipantProfile.create(participant_profile_params)
    participant.participant_profile = participant_profile
    participant.name = participant_profile.name
    if participant.save
      redirect_to participants_path, :notice => "Participante criado com sucesso"
    end
  end

  # APP  endpoints
  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end


  private
  def participant_profile_params
    params.require(:participant_profile).permit(:first_name,:last_name, :birthdate, :occupation, :city, :state, :country, :facebook, :instagram, :whatsapp, :youtube, :snapchat)
  end
end
