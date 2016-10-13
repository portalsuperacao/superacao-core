class ActivationCodeController < BaseController
  def activate
    jwt_service = JWTAuthService.new(request.env['HTTP_AUTHORIZATION'])
    jwt_service.authenticate

    if jwt_service.authenticated?
      activation_code = ActivationCode.find_by_code(params[:code])

      if activation_code
         unless activation_code.activated
           activation_code.activated = true
           activation_code.activated_at = Date.today
           activation_code.save

           participant = activation_code.participant
           participant.uid = jwt_service.uid
           participant.save!

           render json: participant
         else
           api_error(status: 422, errors: {failed: ['Activation code already used']})
         end
      else
         api_error(status: 404, errors: {failed: ['Activation code not found']})
      end
    else
      api_error(status: 401)
    end
  end
end
