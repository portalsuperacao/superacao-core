class ActivationCodeController < BaseController
  before_action do |controller|
    authenticate(skip_user_load:true)
  end

  def activate
    activation_code = ActivationCode.find_by_code(params[:code])

    if activation_code
       unless activation_code.activated
         participant = activation_code.participant
         participant.uid = @uid

         participant.save!
         render json: lesson, {success:true}, status: 200
       else
         api_error(status: 422, errors: {failed: ['Activation code already used']})
       end
    end
    api_error(status: 404, errors: {failed: ['Activation code not found']})
  end
end
