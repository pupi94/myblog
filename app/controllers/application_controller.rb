class ApplicationController < ActionController::Base

  def self.in_development?
    'development' == Rails.env
  end

  rescue_from Exception, :with => :render_error unless in_development?
  rescue_from RuntimeError, :with => :render_error unless in_development?
  rescue_from ActiveRecord::RecordNotFound, :with => :render_error unless in_development?
  rescue_from ActionController::RoutingError, :with => :render_not_found unless in_development?
  rescue_from ActionController::UnknownController, :with => :render_error unless in_development?
  rescue_from AbstractController::ActionNotFound, :with => :render_error unless in_development?

  def login_required
    unless current_user
      respond_to do |format|
        format.html {
          redirect_to users_login_path
        }
      end
    end
  end

  def render_error(exception = nil)
    render layout: false, :file => "#{Rails.root}/public/500.html"
  end

  def render_not_found(exception = nil)
    render layout: false, :file => "#{Rails.root}/public/404.html"
  end

  def current_user
    return nil unless session['user']
    return session['user'] if session['user']
  end
end
