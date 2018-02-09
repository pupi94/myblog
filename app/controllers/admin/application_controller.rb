module Admin
  class ApplicationController < ::ApplicationController
    layout 'admin'

    before_action :login_required

    def login_required
      redirect_to(login_path) unless current_user
    end

    private

    def current_user
      session['user']
    end
  end
end
