# frozen_string_literal: true

module RenderHelper
  extend ActiveSupport::Concern

  def render_unprocessable_entity(error)
    render json: { error: error }, status: :unprocessable_entity
  end

  def render_not_found
    render json: { error: I18n.t("error.not_found") }, status: :not_found
  end

  def render_ok
    render json: {}, status: :ok
  end
end
