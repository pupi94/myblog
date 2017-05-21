class ContentManageController < ApplicationController
  before_filter :login_required
  layout "cm_application"

  def index
  end
end

