class ArticlesController < ApplicationController
  before_action :load_article, only: [:show]
  include RedisHelper

  def index
    @articles = ArticleQuery.new(Article.published).search(query_params)
    @pagy, @articles = pagy(@articles)
  end

  after_action :article_pv, only: :show
  def show
    raise ActiveRecord::RecordNotFound.new unless @article.published?
    @article.pv += redis_client.pfcount(article_pv_key(@article.id)).to_i
  end

  private
  def article_pv
    redis_client.pfadd(article_pv_key(@article.id), request.remote_ip || session.id)

    Rails.logger.info("文章 #{@article.id} 访问量加1： 访问者的IP是： #{request.remote_ip || session.id}")
  end

  def load_article
    @article = current_user.articles.find(params[:id])
  end

  def article_pv_key(id)
    "article::#{id}::pv"
  end
end