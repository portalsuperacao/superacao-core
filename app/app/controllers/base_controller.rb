class BaseController < ApplicationController
  protect_from_forgery with: :null_session

  before_action :destroy_session

  rescue_from Exception, with: :unknow_error
  rescue_from ActiveRecord::RecordInvalid, with: :validation
  rescue_from ActiveRecord::RecordInvalid, with: :validation

  def not_found
    return api_error(status: 404, errors: 'Not found')
  end

  def unknow_error(e)
    Rails.logger.error(e)
    return api_error(status: 520, errors: 'Sorry, something happened on our side.')
  end

  def validation(e)
    if Rails.env.development?
      return api_error(status: 422, errors: e.record.errors)
    end
  end

  def destroy_session
    request.session_options[:skip] = true
  end

  def api_error(status: 500, errors: [])
     unless Rails.env.production?
       puts errors
       puts errors.full_messages if errors.respond_to? :full_messages
     end
     head status: status and return if errors.empty?

     render json: errors, status: status
  end

  private
    def authenticate(skip_set_current_user = false)
      begin
        jwt_service = JWTAuthService.new(request.env['HTTP_AUTHORIZATION'])
        jwt_service.authenticate

        @current_uid  = jwt_service.uid

        unless skip_set_current_user
          @current_user = Participant.find_by_uid(@current_uid)
          raise "Participant not found for uid: #{@current_uid}" if !@current_user
        end
      rescue Exception => e
        logger.error("Failed to verify jwt due to: '#{e.message}'")
        api_error(status: 401)
      end
    end
end
