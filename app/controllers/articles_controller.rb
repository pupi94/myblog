class ArticlesController < ApplicationController

  def search
    search_params = params.permit(:page, :wd)
    search_params['page_size'] = 15

    if params[:category].present?
      search_params['category'] = categories_en_name_hash[params[:category]]['id']
    end

    search_params['status'] = "published"

    articles, count = Article.search(search_params, order_by: :pubdate)
    @articles = Kaminari.paginate_array(articles||[], total_count: count)
      .page(search_params[:page].to_i).per(search_params['page_size'])
  end

  after_action :article_pv, only: :show
  def show
    @article = Article.find(params[:id])
    raise ActiveRecord::RecordNotFound.new unless @article.status == "published"

    @article.pv += BlogRedis.pfcount(article_pv_key(@article.id)).to_i
  end

  private
  def article_pv
    BlogRedis.pfadd(article_pv_key(@article.id), request.remote_ip || session.id)

    Log.info("文章 #{@article.id} 访问量加1： 访问者的IP是： #{request.remote_ip || session.id}")
  end

  def article_pv_key(id)
    "article::#{id}::pv"
  end
end