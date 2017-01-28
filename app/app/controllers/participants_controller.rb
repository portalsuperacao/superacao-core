class ParticipantsController < BaseController
  before_action :authenticate, only: :trinities

  def index
    @participants = Participant.joins(:participant_profile)
                               .left_outer_joins(:missions)
                               .distinct().select('participants.*, participant_profiles.*, COUNT(missions.*) as missions_count')
                               .group('participants.id, participant_profiles.id ')
                               .page(params[:page])
                               .order(created_at: :desc)

    if params[:type]
      @participants = @participants.where(type: params[:type].camelize)
    end
  end

  def show
    @participant = Participant.find(params[:id])
    @profile = @participant.profile
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


  private
  def participant_profile_params
    params.require(:participant_profile).permit(:first_name,:last_name, :birthdate, :occupation, :city, :state, :country, :facebook, :instagram, :whatsapp, :youtube, :snapchat)
  end
end
