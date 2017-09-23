class ManagementController < ApplicationController
  before_filter :login_required
  layout 'management_application'

  def index
  end
end

