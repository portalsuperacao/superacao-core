class ParticipantsController < BaseController
  before_action :authenticate

  def trinities
    unless @current_user
      participant = Participant.find(params[:id])
    else
      participant = @current_user
    end

    render :json, participant.trinities
  end
end
