class ArticlesController < ApplicationController
  before_filter :login_required
  layout "management_application"

  def index

  end

  def new
    tags_rtn = Tag.search params
    @tags = tags_rtn['tags'] || []
    categories_rtn = Category.search({'enabled' => true})
    @categories = categories_rtn['categories'] || []
  end

  def create
    puts params.as_json
    article = params.slice(*%w(source_type title blog category tags summary source source_url))
    #redirect_to index
  end
end