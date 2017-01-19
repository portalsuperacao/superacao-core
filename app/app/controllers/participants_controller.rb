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

  # APP  endpoints
  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end
end
