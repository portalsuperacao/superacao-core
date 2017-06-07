class ParticipantsController < BaseController
  include CreateParticipant

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

  def new
    @participant = Participant.new
    @participant.build_participant_profile
  end

  def show
    show_participant(Participant.find(params[:id]))
  end
end
