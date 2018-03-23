class Article < ApplicationRecord
  include MarkdownTool

  validates_presence_of :title, message: ErrorCode::ERR_ARTICLE_TITLE_CANNOT_BE_BLANK
  validates_presence_of :source_type, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_CANNOT_BE_BLANK
  validates_presence_of :category_id, message: ErrorCode::ERR_ARTICLE_CATEGORY_ID_CANNOT_BE_BLANK
  validates_presence_of :tags, message: ErrorCode::ERR_ARTICLE_TAGS_CANNOT_BE_BLANK
  validates_presence_of :author_id, message: ErrorCode::ERR_ARTICLE_AUTHOR_ID_CANNOT_BE_BLANK
  validates_presence_of :author_name, message: ErrorCode::ERR_ARTICLE_AUTHOR_NAME_CANNOT_BE_BLANK

  validates :title, length: { maximum: 64, message: ErrorCode::ERR_ARTICLE_TITLE_THE_MAXIMUM_LENGTH_OF_64 }
  validates :source, length: { maximum: 64, message: ErrorCode::ERR_ARTICLE_SOURCE_THE_MAXIMUM_LENGTH_OF_64 }
  validates :source_url, length: { maximum: 128, message: ErrorCode::ERR_ARTICLE_SOURCE_URL_THE_MAXIMUM_LENGTH_OF_128 }
  validates :tags, length: { maximum: 64, message: ErrorCode::ERR_ARTICLE_TAGS_THE_MAXIMUM_LENGTH_OF_64 }
  validates :summary, length: { maximum: 255, message: ErrorCode::ERR_ARTICLE_SUMMARY_THE_MAXIMUM_LENGTH_OF_255 }
  validates :attachment, length: {maximum: 128, message: ErrorCode::ERR_ARTICLE_ATTACHMENT_THE_MAXIMUM_LENGTH_OF_128 }

  validates :source_type,  inclusion: {in: SourceType.const_values, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_INVALID}
  validates :status,  inclusion: {in: ArticleStatus.const_values, message: ErrorCode::ERR_ARTICLE_STATUS_INVALID}

  belongs_to :category

  before_save :update_content_html
  def update_content_html
    self.content_html = convert_html(self.content)
  end

  def self.search_for_admin(params)
    Util.try_rescue do |response|
      articles = all
      articles = (params.has_key?('enabled') && params['enabled'] == false) ? articles.disabled : articles.enabled
      articles = articles.where(category_id: params['category']) if params['category'].present?
      articles = articles.where(status: params['status']) if params['status'].present?
      params['title'] = params['title'].strip if params['title'].present?
      articles = articles.where('title like ?', "%#{params['title']}%") if params['title'].present?

      response['total_count'] = articles.size
      return response if response['total_count'] == 0

      articles = articles.order(created_at: :desc).page_filter(params['page_size'], params['page'])

      search_column = %w[id title source_type tags pv pubdate status created_at]
      response['articles'] = articles.select(*search_column)
    end
  end

  def self.search params
    Util.try_rescue do |response|
      articles = Article.where(status: ArticleStatus::PUBLISHED).order(pubdate: :desc)
      response['count'] = articles.size
      return response if response['count'] == 0
      articles = articles.page_filter(params['page_size'], params['page'])
      response['articles'] = articles.select(*%w[id category_id summary title pv pubdate])
    end
  end

  def self.update_status id
    article = find_by(id: id)
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
      article.handle_save
    end
  end
end