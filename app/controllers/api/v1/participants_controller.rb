class Api::V1::ParticipantsController < BaseController
  before_action :authenticate, only: :trinities

  def index
    @participants = Participant.joins(:participant_profile).includes(:participant_profile)
                               .group('participants.id,participant_profiles.id')

   if params[:name]
     @name = params[:name]
     @participants = Participant.search_by_full_name(@name)
   end

    if params[:type]
      @participants = @participants.where(type: params[:type].camelize)
    end
    @participants = @participants.page(params[:page])
    .order(created_at: :desc)
  end

  def show
    @participant = Participant.find(params[:id])
    @profile = @participant.profile

    respond_to do |format|
      format.html
      format.json { render json: @participant, include: 'participant_profile,current_treatment_profile,current_treatment_profile.treatments,current_treatment_profile.cancer_treatments,past_treatment_profile.treatments,past_treatment_profile.cancer_treatments'}
    end
  end

  def new
    @participant_profile = ParticipantProfile.new
  end

  def create
    pariticipant_type = params["participant_profile"]["participant_type"]
    participant = Object.const_get(pariticipant_type.capitalize).new
    participant_profile = ParticipantProfile.create(participant_profile_params)
    participant.participant_profile = participant_profile
    if participant.save
      redirect_to participants_path, :notice => "Participante criado com sucesso"
    end
  end

  # APP  endpoints
  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end

  def create_app
    byebug
    pariticipant_type = params["participant_profile"]["participant_type"]
    participant = Object.const_get(pariticipant_type.capitalize).new
    participant_profile = ParticipantProfile.create(participant_profile_params)
    participant.participant_profile = participant_profile
  end

  private
  def participant_profile_params
    params.require(:participant_profile).permit(:first_name,:last_name,
    :birthdate, :occupation, :city, :state, :country,
    :facebook, :instagram, :whatsapp, :youtube, :snapchat)
  end
end
