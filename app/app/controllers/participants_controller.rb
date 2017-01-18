class ParticipantsController < BaseController
  before_action :authenticate, only: :trinities

  def index
    if params[:type]
      @participants = Participant.where(type: params[:type]).includes(:participant_profile).page(params[:page])
    else
      @participants = Participant.all.includes(:participant_profile).page(params[:page])
    end
  end

  # APP  endpoints
  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end
end
