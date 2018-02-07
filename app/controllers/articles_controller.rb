class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])

    p "show================"
    p @article.as_json
  end
end