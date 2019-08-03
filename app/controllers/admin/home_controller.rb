# frozen_string_literal: true

module Admin
  class HomeController < ::AdminController
    before_action :authenticate_user!

    def index; end
  end
end
