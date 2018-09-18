class HomeController < ApplicationController
  include Pagy::Backend
	
  def index
    @articles = ArticleQuery.new(Article.published).search({})
    @pagy, @articles = pagy(@articles)
  end

end