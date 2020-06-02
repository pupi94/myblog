# frozen_string_literal: true

module Api
  class Admin::BaseController < BaseController
    layout "admin"
    before_action :authenticate_user!
  end
end
