class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  def paginate(scope, default_per_page = 10)
    scope.page(params[:page]).per(default_per_page)

    # @articles = Kaminari.paginate_array(articles||[], total_count: total_count)
    #   .page(params[:page].to_i).per(15)
  end
end