module Admin
  class ApplicationController < ::ApplicationController
    layout BlogLayout::ADMIN

    before_action :authenticate_user!
  end
end