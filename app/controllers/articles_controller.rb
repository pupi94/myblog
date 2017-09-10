class ArticlesController < ApplicationController
  before_action :login_required
  layout "management_application"

  def index
    rtn = Article.search(params)
    if Util.success? rtn
      @articles = Kaminari.paginate_array(
        rtn['articles'], total_count: rtn['total_count']
      ).page(params[:page].to_i).per(DEFAULT_PAGE_SIZE)
    else
      @msg = rtn['return_info']
    end
  end

  def new
    categories_rtn = Category.search({'enabled' => true})
    @categories = categories_rtn['categories'] || []
  end

  def create
    params['author_id'] = current_user['id']
    params['author_name'] = current_user['username']
    rtn = Article.create(params)
    if Util.success? rtn
      redirect_to articles_index_path
    else
      render :new
    end
  end

  def show

  end
end