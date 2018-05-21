module Admin
  class ArticlesController < ApplicationController
    layout BlogLayout::ADMIN

    def index
      articles, total_count = Article.search(params.permit(:category, :title, :status, :page, :page_size))
      @articles = Kaminari.paginate_array(articles||[], total_count: total_count)
        .page(params[:page].to_i).per(DEFAULT_PAGE_SIZE)
    end

    def trash
      articles, total_count = Article.search(params.permit(:category, :title, :page, :page_size), enabled: false)

      @articles = Kaminari.paginate_array(articles||[], total_count: total_count)
        .page(params[:page].to_i).per(DEFAULT_PAGE_SIZE)
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      @article.author_id   = current_user.id
      @article.author_name = current_user.username
      @article.status = ArticleStatus::EDITING
      @article.save!
      redirect_to admin_articles_path
    end

    def update_status
      article = Article.find(params[:id])
      article.update_status
      render json: success_json
    end

    def edit
      @article = Article.find(params[:id])
    end

    def update
      article = Article.find(params[:id])
      article.update!(article_params)
      redirect_to admin_articles_path
    end

    def show
      @article = Article.find(params[:id])
      @article.pv += BlogRedis.pfcount("article::#{@article.id}::pv").to_i
      render 'articles/show', layout: BlogLayout::APPLICATION
    end

    private
    def article_params
      params.require(:article).permit(
        :source_type, :title, :category_id, :tags, :summary, :content, :source, :source_url
      )
    end
  end
end