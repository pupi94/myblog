# frozen_string_literal: true

module RenderHelper
  extend ActiveSupport::Concern

  def render_internal_server_error
    render json: { error: I18n.t("error.server_error") }, status: :internal_server_error
  end

  def render_unprocessable_entity(error)
    render json: { error: error }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: I18n.t("error.not_found") }, status: :unprocessable_entity
  end

  def render_ok
    render json: {}, status: :ok
  end
end
