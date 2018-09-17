module Admin
  class ArticlesController < ::AdminController
    include Pagy::Backend
    before_action :load_article, only: [:publish, :edit, :show, :update]

    def index
      @articles = ArticleQuery.new(current_user.articles).search(query_params)
      @pagy, @articles = pagy(@articles)
    end

    def new
      @article = Article.new
    end

    def create
      @article = current_user.articles.new(article_params)
      @article.save!
      redirect_to admin_articles_path
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_admin_article_path,
        status: :unprocessable_entity,
        flash: { errors: e.record.errors.full_messages }
    end

    def publish
      @article.publish!
      redirect_to admin_articles_path
    end

    def edit
    end

    def update
      @article.update!(article_params)
      redirect_to admin_articles_path
    end

    def show
      @article.pv += BlogRedis.pfcount("article::#{@article.id}::pv").to_i
      render 'articles/show', layout: "application"
    end

    private
    def article_params
      params.require(:article).permit(:title, :label_id, :summary, :body)
    end

    def query_params
      params.permit(:title, :status, :label_id)
    end

    def load_article
      @article = current_user.articles.find(params[:id])
    end
  end
end