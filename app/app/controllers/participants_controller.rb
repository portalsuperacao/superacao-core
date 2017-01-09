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

  def firebase_token
    render plain: "ok"
    # render template: "tmp/firebase_token.html.erb"
  end
end
