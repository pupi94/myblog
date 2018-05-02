class ArticlesController < ApplicationController
  include CategoryHelper

  def search
    search_params = params.permit(:page, :wd)
    search_params['page_size'] = ARTICLE_PAGE_SIZE

    if params[:category].present?
      search_params['category_id'] = find_category_by_name_en(params[:category])['id']
    end

    articles, count = Article.search(search_params)
    @articles = Kaminari.paginate_array(articles||[], total_count: count)
      .page(search_params[:page].to_i).per(search_params['page_size'])
  end

  def show
    @article = Article.find(params[:id])
  end
end