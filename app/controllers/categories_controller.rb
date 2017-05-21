class CategoriesController < ApplicationController
  before_filter :login_required

  layout :resolve_layout

  def index
    rtn = Category.search({})
    if Util.success? rtn
      @categories = rtn['categories']
    else
      @categories = nil
      @msg = rtn['return_info']
    end
  end

  def create
    rtn = Category.create(params)
    render :json =>rtn
  end

  private
  def resolve_layout
    case action_name
    when 'index', 'create'
      'cm_application'
    else
      'application'
    end
  end
end