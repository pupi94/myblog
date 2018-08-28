module Admin
  class HomeController < ::AdminApplicationController
    before_action :authenticate_user!

    def index
    end
  end
end

