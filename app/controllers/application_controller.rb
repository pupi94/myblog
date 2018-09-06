class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Exception, :with => :server_error

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordInvalid, :with => :record_invalid

  private
  def record_invalid(e)
    error = e.record.errors.full_messages.first
    respond_to do |format|
      format.html { render "error/500" }
      format.js { render_unprocessable_entity(error) }
      format.json { render_unprocessable_entity(error) }
    end
  end

  def server_error(e)
    Rails.logger.error(e)
    respond_to do |format|
      format.html { render "error/500" }
      format.js { render_internal_server_error }
      format.json { render_internal_server_error }
    end
  end

  def record_not_found
    respond_to do |format|
      format.html { render "error/404" }
      format.js { render_not_found }
      format.json { render_not_found }
    end
  end

  def render_internal_server_error
    render json: { error: I18n.t("error.server_error") }, status: :internal_server_error
  end

  def render_unprocessable_entity(error)
    render json: { error: error }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: I18n.t('error.not_found') }, status: :unprocessable_entity
  end

  def render_ok
    render json: { }, status: :ok
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
