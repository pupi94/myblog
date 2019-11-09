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
    redirect_to admin_articles_path
  rescue ActiveRecord::RecordInvalid => e
    redirect_to new_admin_article_path, status: :unprocessable_entity, flash: { errors: e.record.errors.full_messages }
  end

  def publish
    @article.publish!
    redirect_to admin_articles_path
  end

  def unpublish
    @article.unpublish!
    redirect_to admin_articles_path
  end

  def destroy
    @article.destroy!
    redirect_to admin_articles_path
  end

  def edit
  end

  def update
    @article.update!(article_params)
    redirect_to admin_articles_path
  end

  def show
    render "articles/show", layout: "application"
  end

  private
    def article_params
      params.require(:article).permit(:title, :label_id, :body)
    end

    def query_params
      params.permit(:keyword, :published, :label_id, :page, :per_page)
    end

    def load_article
      @article = current_user.articles.find(params[:id])
    end
end
