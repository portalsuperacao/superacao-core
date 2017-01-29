class ActivationCodeController < BaseController
  before_action {authenticate(skip_set_current_user:true)}

  def activate
    activation_code = ActivationCode.find_by_code(params[:code])

    return head :not_found unless activation_code
    return head :unprocessable_entity if activation_code.activated

    participant = activation_code.participant
    participant.transaction do
      begin
        participant.uid = @current_uid
        participant.save!

        activation_code.activated = true
        activation_code.activated_at = Date.today
        activation_code.save

        render json: participant
      rescue ActiveRecord::RecordInvalid  => invalid
        render json: invalid, status: :precondition_failed
      rescue
        head :internal_server_error
      end
    end

  end
end
