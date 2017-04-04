class ArticlesController < ApplicationController
  before_filter :login_required
  layout "admin"

  def index

  end

  def new
    tags_rtn = Tag.search params
    @tags = tags_rtn['tags'] || nil
    categories_rtn = Category.search({'enable' => true})
    @categories = categories_rtn['categories'] || nil
  end

  def create
  end
end