class ApplicationController < ActionController::Base
  include RenderHelper
  include ExceptionHandleHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
