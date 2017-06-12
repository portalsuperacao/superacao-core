require 'active_support/concern'

module CreateParticipant
  extend ActiveSupport::Concern

  def create_participant(link_firebase_user = false)
    participant_type = params["participant"]["type"]
    @participant = Object.const_get(participant_type.capitalize).create(participant_params)
    @participant.uid = @current_uid if link_firebase_user

    if @participant.save
      respond_to do |format|
        format.html {
            redirect_to participants_path, :notice => "Participante criado com sucesso"
        }
        format.json {
          render json: @participant, include: 'participant_profile,current_treatment_profile,current_treatment_profile.treatments,current_treatment_profile.cancer_treatments,past_treatment_profile.treatments,past_treatment_profile.cancer_treatments'
        }
      end
    else
      respond_to do |format|
        format.html {
          flash[:warning] = @participant.errors.full_messages.to_sentence
          render :new
        }
        format.json {
          render :json => @participant.errors.full_messages.to_sentence, :status => :unprocessable_entity
        }
      end
    end
  end

  def show_participant(participant)
    @participant = participant
    @profile = @participant.profile

    respond_to do |format|
      format.html
      format.json { render json: @participant, include: 'participant_profile,current_treatment_profile,current_treatment_profile.treatments,current_treatment_profile.cancer_treatments,past_treatment_profile.treatments,past_treatment_profile.cancer_treatments'}
    end
  end

  private
  def participant_params
    params.require(:participant).permit(:pacient, :cancer_status,
    participant_profile_attributes: [:first_name,:last_name ,
    :birthdate, :occupation, :city, :state, :country,
    :facebook, :instagram, :whatsapp, :youtube, :snapchat],
    past_treatment_profile_attributes: [ :metastasis,:relapse,
      { treatments_attributes: [ :status, :treatment_type_id, :treatable_type ] },
      { cancer_treatments_attributes: [ :cancer_type_id, :cancerous_type ] } ],
    current_treatment_profile_attributes: [ :metastasis,:relapse,
      { treatments_attributes: [ :status, :treatment_type_id, :treatable_type ] },
      { cancer_treatments_attributes: [ :cancer_type_id, :cancerous_type ] }])
  end
end
