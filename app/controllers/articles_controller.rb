class ArticlesController < ApplicationController
  before_action :login_required
  layout 'management_application'

  def index
    search_params = params.permit(:category, :title, :status, :page, :page_size)
    do_search search_params
  end

  def trash_list
    search_params = params.permit(:category, :title, :page, :page_size)
    search_params['enabled'] = false
    do_search search_params
  end

  def new

  end

  def edit
    search_params = params.permit(:id)
    search_params['enabled'] = true
    rtn = Article.show(search_params)
    if Util.success? rtn
      @article = rtn['article']
    else
      log_error rtn
      render_not_found
    end
  end

  def update
    p "============================="
    p params
    render :edit
  end

  def update_status
    render json: Article.update_status(params)
  end

  def create
    params['author_id'] = current_user['id']
    params['author_name'] = current_user['username']
    rtn = Article.create(params)
    if Util.success? rtn
      redirect_to articles_index_path
    else
      log_error rtn
      render :new
    end
  end

  def show

  end

  private
  def do_search search_params
    rtn = Article.search_for_management(search_params)
    if Util.success? rtn
      @articles = Kaminari.paginate_array(
        rtn['articles'], total_count: rtn['total_count']
      ).page(search_params[:page].to_i).per(DEFAULT_PAGE_SIZE)
    else
      log_error rtn
      @msg = rtn['return_info']
    end
  end
end