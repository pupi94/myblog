class Article < ApplicationRecord
  include MarkdownTool
  include Validates::ArticleValidate

  belongs_to :category

  before_save :update_content_html
  def update_content_html
    self.content_html = convert_html(self.content)
  end

  class << self
    def search_for_admin(params)
      articles = self.all
      articles = (params.has_key?('enabled') && false == params['enabled']) ? articles.disabled : articles.enabled
      articles = articles.where(category_id: params['category']) if params['category'].present?
      articles = articles.where(status: params['status']) if params['status'].present?
      params['title'] = params['title'].strip if params['title'].present?
      articles = articles.where('title like ?', "%#{params['title']}%") if params['title'].present?

      total_count = articles.size
      return nil, total_count if total_count == 0

      articles = articles.order(created_at: :desc).page_filter(params['page_size'], params['page'])

      search_column = %w[id title source_type tags pv pubdate status created_at]
      articles = articles.select(*search_column)
      return articles, total_count
    end

    def search params
      articles = self.where(status: ArticleStatus::PUBLISHED).order(pubdate: :desc)
      total_count = articles.size
      return nil, 0 if total_count == 0
      articles = articles.page_filter(params['page_size'], params['page'])
      articles = articles.select(*%w[id category_id summary title pv pubdate])
      return articles, total_count
    end

    def update_status id
      return CommonException.new(ErrorCode::ERR_ARTICLE_PARAMS_ID_CAN_NOT_BE_BLANK).result if id.blank?
      article = self.find_by(id: id)
      unless article && article.enabled
        return CommonException.new(ErrorCode::ERR_ARTICLE_DOES_NOT_EXIT).result
      end

      Util.try_rescue do |response|
        if [ArticleStatus::EDITING, ArticleStatus::SOLD_OUT].include?(article.status)
          article.status = ArticleStatus::PUBLISHED
          article.pubdate = Time.now
        else
          article.status = ArticleStatus::SOLD_OUT
        end
        article.save
      end
    end
  end
end