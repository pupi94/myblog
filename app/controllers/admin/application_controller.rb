module Admin
  class ApplicationController < ::ApplicationController
    before_action :login_required

    layout 'admin'

    def login_required
      redirect_to(login_path) unless current_user
    end

    private

    def current_user
      session['user']
    end
  end
end
