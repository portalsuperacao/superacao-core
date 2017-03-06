class Api::V1::ActivationCodeController < BaseController
  before_action :authenticate, only: [:activate]

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

  def swagger
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
    
    render json: File.read("lib/swagger/doc.json")
  end

  private
  def authenticate
    super(skip_set_current_user:true)
  end
end
