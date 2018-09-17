class ArticlesController < ApplicationController
  before_action :load_article, only: [:show]

  def index
    search_params = params.permit(:page, :wd)
    search_params['page_size'] = 15

    if params[:category].present?
      search_params['category'] = categories_en_name_hash[params[:category]]['id']
    end

    search_params['status'] = "published"

    articles, count = Article.search(search_params, order_by: :pubdate)
    #@articles = Kaminari.paginate_array(articles||[], total_count: count)
      #.page(search_params[:page].to_i).per(search_params['page_size'])
  end

  after_action :article_pv, only: :show
  def show
    raise ActiveRecord::RecordNotFound.new unless @article.published?
    @article.pv += BlogRedis.pfcount(article_pv_key(@article.id)).to_i
  end


  private
  def article_pv
    BlogRedis.pfadd(article_pv_key(@article.id), request.remote_ip || session.id)

    Log.info("文章 #{@article.id} 访问量加1： 访问者的IP是： #{request.remote_ip || session.id}")
  end

  def load_article
    @article = current_user.articles.find(params[:id])
  end

  def article_pv_key(id)
    "article::#{id}::pv"
  end
end