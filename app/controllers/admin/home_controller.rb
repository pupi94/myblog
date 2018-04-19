module Admin
  class HomeController < ApplicationController
    layout BlogLayout::ADMIN

    before_action :authenticate_user!

    def index
    end
  end
end

