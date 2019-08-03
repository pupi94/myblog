class HomeController < ApplicationController

  def index
    @articles = Article.published.order(published_at: :desc).limit(6)
  end
end