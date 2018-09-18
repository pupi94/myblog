class HomeController < ApplicationController

  def index
    @articles = Article.published.order(pubdate: :desc).limit(6)
  end
end