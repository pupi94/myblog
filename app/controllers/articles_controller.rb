# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :load_article, only: [:show]

  def index
    @articles = ArticleQuery.new(query_params).query
    @pagy = Pagy.new_from_searchkick(@articles)
  end

  def show; end

  private
    def query_params
      params.permit(:wd, :page)
    end

    def article_pv
      key = cache_key(@article.id)
      @article.pageview += Rails.cache.redis.pfcount(key).to_i
      Rails.cache.redis.pfadd(key, request.remote_ip || session.id)

      Rails.logger.info("文章 #{@article.id} 访问量加1： 访问者的IP是： #{request.remote_ip || session.id}")
    end

    def cache_key(id)
      "article::#{id}::pv"
    end

    def load_article
      @article = Article.published.find(params[:id])
    end
end
