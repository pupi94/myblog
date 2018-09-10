module Admin
  class ArticlesController < ::AdminController

    def index
      articles, total_count = Article.search(params.permit(:title, :status, :page, :page_size))


      @articles = Kaminari.paginate_array(articles||[], total_count: total_count)
        .page(params[:page].to_i).per(15)
    end

    def new
      @article = Article.new
    end

    def create
      @article = current_user.articles.new(create_params)
      @article.save!
      redirect_to admin_articles_path
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_admin_article_path,
        status: :unprocessable_entity,
        flash: { errors: e.record.errors.full_messages }
    end

    def publish
      article = Article.find(params[:id])
      article.publish
      redirect_to admin_articles_path
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

    def delete
      article = Article.find(params[:id])
      article.enabled = false
      article.save!
      redirect_to admin_articles_path
    end

    private
    def create_params
      params.require(:article).permit(:title, :label_id, :summary, :body)
    end
  end
end