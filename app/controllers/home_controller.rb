class HomeController < ApplicationController
	
  def index
    search_params = params.permit(:page, :wd)
    search_params['page_size'] = 15

    articles, count = Article.search(search_params)

    #@articles = Kaminari.paginate_array(articles||[], total_count: count)
      #.page(search_params[:page].to_i).per(search_params['page_size'])
  end

  def paging_search
    index
  end

  private

  def search_params

  end
end