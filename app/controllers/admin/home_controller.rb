module Admin
  class HomeController < ::AdminController
    before_action :authenticate_user!

    def index
    end
  end
end

