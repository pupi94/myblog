class HomeController < ApplicationController
	
  def index
    search_params = params.permit(:page)
    search_params['page_size'] = IAS_DEFAULT_PAGE_SIZE
    @articles, @count = Article.search(search_params)
    @page = (params['page'] || DEFAULT_PAGE).to_i
    @page_size = search_params['page_size']
  end

  def paging_search
    index
  end

  private

  def search_params

  end
end