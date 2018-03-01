class ApplicationController < ActionController::Base

  rescue_from Exception, :with => :render_error unless Rails.env.development?
  rescue_from RuntimeError, :with => :render_error unless Rails.env.development?
  rescue_from ActiveRecord::RecordNotFound, :with => :render_error unless Rails.env.development?
  rescue_from ActionController::RoutingError, :with => :render_not_found unless Rails.env.development?
  rescue_from ActionController::UnknownController, :with => :render_error unless Rails.env.development?
  rescue_from AbstractController::ActionNotFound, :with => :render_error unless Rails.env.development?

  def log_error rtn
    Log.error "#{rtn['return_code']}: #{rtn['return_info']}"
  end

  def render_error(e = nil)
    Log.error e
    render "error/500"
  end

  def render_not_found(e = nil)
    Log.error e
    render 'error/404'
  end
end
