class Api::V1::ParticipantsController < BaseController
  include CreateParticipant

  before_action :authenticate

  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end

  def show
    show_participant(Participant.find_by(uid: @current_uid))
  end
end
