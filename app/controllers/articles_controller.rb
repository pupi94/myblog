class ArticlesController < ApplicationController
  before_filter :login_required
  layout "admin"

  def index

  end

  def new
    
  end
end