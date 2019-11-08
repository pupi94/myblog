# frozen_string_literal: true
module Api
  module Admin
    class BaseController < ::ApplicationController
      layout "admin"
      before_action :authenticate_user!
    end
  end
end