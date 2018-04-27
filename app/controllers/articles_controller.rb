class ArticlesController < ApplicationController
  include CategoryHelper

  def search
    search_params = {
      'page' => params[:page],
      'page_size' => IAS_DEFAULT_PAGE_SIZE
    }
    
    if params[:category].present?
      search_params['category_id'] = find_category_by_name_en(params[:category])['id']
    end

    @articles, @count = Article.search(search_params)
    @page = (params['page'] || DEFAULT_PAGE).to_i
    @page_size = search_params['page_size']
  end

  def show
    @article = Article.find(params[:id])
  end
end