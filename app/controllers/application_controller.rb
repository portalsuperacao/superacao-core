class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveModel::ValidationError, :with => :render_validation_error

  private
    def record_not_found(error)
     render :json => error.message, :status => :not_found
    end

    def render_validation_error(error)
      render :json => error.message, :status => :unprocessable_entity
    end
end
