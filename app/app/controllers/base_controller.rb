class BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  #rescue_from ActiveRecord::RecordInvalid, with: :validation

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  # def validation(e)
  #   return api_error(status: 422, errors: e.record.errors)
  # end

  def destroy_session
    request.session_options[:skip] = true
  end

  def api_error(status: 500, errors: [])
     unless Rails.env.production?
       puts errors.full_messages if errors.respond_to? :full_messages
     end
     head status: status and return if errors.empty?

     render json: errors, status: status
  end

  private
    def authenticate(options)
      begin
        jwt_service = JWTAuthService.new(request.env['HTTP_AUTHORIZATION'])
        jwt_service.authenticate(options)

        @current_user = jwt_service.current_user
      rescue Exception => e
        logger.error("Failed to verify jwt due to: '#{e.message}'")
        api_error(status: 401)
      end
    end
end
