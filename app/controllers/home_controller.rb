class HomeController < ApplicationController
	
  def index
    search_params = params.permit(:page)
    search_params['page_size'] = IAS_DEFAULT_PAGE_SIZE
    rtn = Article.search(search_params)
    if Util.success? rtn
      @articles = rtn['articles']
      @page = (params['page'] || DEFAULT_PAGE).to_i
      @count = rtn['count']
      @page_size = search_params['page_size']
    end
  end

  def paging_search
    index
  end

  private

  def search_params

  end
end