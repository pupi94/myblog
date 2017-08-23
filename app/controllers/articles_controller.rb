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
    article = params.slice(*%w(source_type title content category tags summary source source_url))
    redirect_to articles_index_path
  end

  def show

  end
end