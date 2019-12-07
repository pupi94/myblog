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
      params.permit(:wd, :page, :collection)
    end

    def load_article
      @article = Article.published.find(params[:id])
    end
end
