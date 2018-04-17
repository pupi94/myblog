class ApplicationController < ActionController::Base

  rescue_from Exception, :with => :render_error #unless Rails.env.development?
  rescue_from RuntimeError, :with => :render_error# unless Rails.env.development?
  rescue_from CustomError, :with => :render_custom_error# unless Rails.env.development?

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found# unless Rails.env.development?
  rescue_from ActiveRecord::RecordInvalid, :with => :render_invalid # unless Rails.env.development?
  rescue_from ActionController::UnknownController, :with => :render_error# unless Rails.env.development?
  rescue_from AbstractController::ActionNotFound, :with => :render_error #unless Rails.env.development?

  def render_custom_error(e)
    do_render(e, 'error/500', system_error_json(e.message_zh))
  end

  def render_invalid(e)
    msgs = e.record.errors.messages
    Log.error msgs
    do_render(e, 'error/500', system_error_json(I18n.t(msgs.first[1][0])))
  end

  def render_error(e = nil)
    do_render(e, 'error/500', system_error_json)
  end

  def render_not_found(e = nil)
    do_render(e, 'error/404', no_match_json)
  end

  def do_render(e, page, rtn)
    Log.error e
    respond_to do |format|
      format.html { render page }
      format.js { render json: rtn }
      format.json { render json: rtn }
    end
  end

  private
  def no_match_json
    {'return_code' => 404, 'return_info' => I18n.t('error.resource_not_found')}
  end

  def system_error_json(msg = nil)
    {'return_code' => 500, 'return_info' => msg || I18n.t('error.system_error')}
  end
end
