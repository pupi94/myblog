# frozen_string_literal: true

module Api
  class AdminController < BaseController
    layout "admin"
    before_action :authenticate_user!
  end
end
