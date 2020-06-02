# frozen_string_literal: true

class Api::BaseController < ApplicationController
  include RenderHelper
  include ExceptionHelper

  def paginate(relation)
    relation.limit(per_page).offset((page - 1) * per_page)
  end

  def per_page
    (params[:per_page] || 10).to_i
  end

  def page
    (params[:page] || 1).to_i
  end
end
