class ActivationCodeController < BaseController
  before_action {authenticate(skip_set_current_user:true)}

  def activate
    activation_code = ActivationCode.find_by_code(params[:code])

    if activation_code
       unless activation_code.activated
         participant = activation_code.participant
         participant.uid = @current_uid
         participant.save!

         activation_code.activated = true
         activation_code.activated_at = Date.today
         activation_code.save

         render json: participant
       else
         render status: :unprocessable_entity, json: {failed: ['Activation code already used']}
       end
    else
       render status: :not_found, json: {failed: ['Activation code not found']}
    end
  end
end
