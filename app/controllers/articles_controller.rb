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
    params['author_id'] = current_user['id']
    params['author_name'] = current_user['username']
    rtn = Article.create(params)
    if Util.success? rtn

    end
    redirect_to articles_index_path
  end

  def show

  end
end