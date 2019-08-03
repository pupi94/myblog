# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :load_article, only: [:show]
  include Pagy::Backend

  def index
    @articles = ArticleQuery.new(Article.published).search(query_params)
    @pagy, @articles = pagy(@articles)
  end

  def show; end

  private

  def query_params
    params.permit(:wd)
  end

  # def article_pv
  #   @article.pv += redis_client.pfcount(article_pv_key(@article.id)).to_i
  #   redis_client.pfadd(article_pv_key(@article.id), request.remote_ip || session.id)
  #
  #   Rails.logger.info("文章 #{@article.id} 访问量加1： 访问者的IP是： #{request.remote_ip || session.id}")
  # end
  #
  # def article_pv_key(id)
  #   "article::#{id}::pv"
  # end

  def load_article
    @article = Article.published.find(params[:id])
  end
end
