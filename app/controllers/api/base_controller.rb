# frozen_string_literal: true

class Api::BaseController < ApplicationController
  include RenderHelper
  include ExceptionHelper
end
