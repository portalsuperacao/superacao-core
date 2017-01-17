class ParticipantsController < BaseController
  before_action :authenticate, only: :trinities

  def index
    if params[:type]
      @participant = Participant.where(type: params[:type]).page(params[:page])
    else
      @participant = Participant.all.page(params[:page])
    end
  end

  # APP  endpoints
  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end
end
