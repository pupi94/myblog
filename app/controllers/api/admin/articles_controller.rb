# frozen_string_literal: true

class Api::Admin::ArticlesController < Api::AdminController
  before_action :load_article, only: %i[publish show update unpublish destroy]

  def index
    @articles = Admin::ArticleQuery.new(current_user, query_params).query
    @count = @articles.total_count
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.save!
    render_ok
  end

  def batch_publish
    BatchPublishArticle.new(current_user, article_ids).call
    render_ok
  end

  def batch_unpublish
    BatchUnpublishArticle.new(current_user, article_ids).call
    render_ok
  end

  def destroy
    @article.destroy!
    render_ok
  end

  def edit
  end

  def update
    @article.update!(article_params)
    render_ok
  end

  def show
    render "articles/show", layout: "application"
  end

  private
    def article_params
      params.require(:article).permit(:title, :label_id, :body)
    end

    def query_params
      params.permit(:keyword, :published, :page, :per_page)
    end

    def load_article
      @article = current_user.articles.find(params[:id])
    end

    def article_ids
      params[:ids].to_s.split(",")
    end
end
