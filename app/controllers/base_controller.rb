class BaseController < ApplicationController
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
        head :unauthorized
      end
    end
end
