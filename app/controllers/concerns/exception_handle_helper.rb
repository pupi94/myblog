# frozen_string_literal: true

module ExceptionHandleHelper
  extend ActiveSupport::Concern

  included do
    rescue_from Exception do |ex|
      handle_error ex
      respond_to do |format|
        format.html { render 'error/500' }
        format.js { render_internal_server_error }
        format.json { render_internal_server_error }
      end
    end

    rescue_from ActiveRecord::RecordNotSaved do |ex|
      handle_error ex
      respond_to do |format|
        format.html { render 'error/500' }
        format.js { render_unprocessable_entity(ex.record.errors.full_messages) }
        format.json { render_unprocessable_entity(ex.record.errors.full_messages) }
      end
    end

    rescue_from ActiveRecord::RecordInvalid do |ex|
      handle_error ex
      respond_to do |format|
        format.html { render 'error/500' }
        format.js { render_unprocessable_entity(ex.record.errors.full_messages) }
        format.json { render_unprocessable_entity(ex.record.errors.full_messages) }
      end
    end

    rescue_from ActiveRecord::RecordNotFound do |ex|
      handle_error ex
      respond_to do |format|
        format.html { render 'error/404' }
        format.js { render_not_found }
        format.json { render_not_found }
      end
    end

    def handle_error(ex)
      Rails.logger.error format('%s (%s):', ex.class.name, ex.message)
      Rails.logger.error ex.backtrace.join("\n")
    end
  end
end
