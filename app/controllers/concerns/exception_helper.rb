# frozen_string_literal: true

module ExceptionHelper
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |ex|
      log_error ex
      render_unprocessable_entity(ex.record.errors.full_messages)
    end

    rescue_from ActiveRecord::RecordNotFound do |ex|
      log_error ex
      render_not_found
    end

    def log_error(ex)
      Rails.logger.error format("%s (%s):", ex.class.name, ex.message)
      Rails.logger.error ex.backtrace.join("\n")
    end
  end
end
