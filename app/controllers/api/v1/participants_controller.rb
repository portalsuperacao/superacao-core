class Api::V1::ParticipantsController < BaseController
  include CreateParticipant

  before_action :authenticate, only: :show
  before_action only: [:create] {authenticate(true)}

  def trinities
    render json: @current_user.trinities, include: 'overcomer,angel,archangel'
  end

  def create
    create_participant(true)
  end

  def show
    show_participant(Participant.find_by(uid: @current_uid))
  end
end
