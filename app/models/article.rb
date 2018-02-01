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
  validates :attachment, length: { maximum: 128, message: ErrorCode::ERR_ARTICLE_ATTACHMENT_THE_MAXIMUM_LENGTH_OF_128 }

  validates :source_type,  inclusion: {in: SourceType.const_values, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_INVALID}
  validates :status,  inclusion: {in: ArticleStatus.const_values, message: ErrorCode::ERR_ARTICLE_STATUS_INVALID}


  def self.create(params)
    Util.try_rescue do |response|
      create_params = params.to_unsafe_h.slice(
        *%w'source_type title category_id tags summary content source source_url attachment author_id author_name'
      )
      create_params['status'] = ArticleStatus::EDITING
      create_params['content_html'] = convert_html(create_params['content'])
      handle_create(create_params)
    end
  end

  def self.search_for_management(params)
    Util.try_rescue do |response|
      articles = all

      articles = (!params.has_key?('enabled') || params['enabled']) ? articles.enabled : articles.disabled
      articles = articles.where(category_id: params['category']) if params['category'].present?
      articles = articles.where(status: params['status']) if params['status'].present?
      params['title'] = params['title'].strip if params['title'].present?
      articles = articles.where('title like ?', "%#{params['title']}%") if params['title'].present?

      response['total_count'] = articles.size
      if response['total_count'] == 0
        response['articles'] = {}
        return response
      end

      articles = articles.order(created_at: :desc).page_filter(params['page_size'], params['page'])

      search_column = %w(id title source_type tags pv pubdate status created_at enabled)
      response['articles'] = articles.select(*search_column)
    end
  end

  def self.show(params)
    return CommonException.new(ErrorCode::ERR_ARTICLE_PARAMS_ID_CAN_NOT_BE_BLANK).result if params['id'].blank?

    Util.try_rescue do |response|
      articles = where(id: params['id'])
      articles = articles.enabled if params.has_key?('enabled') && params['enabled']
      articles = articles.where(status: params['status']) if params['status'].present?
      raise CommonException.new(ErrorCode::ERR_ARTICLE_DOES_NOT_EXIT) if articles.nil?
      response['article'] = articles.select(
        *%w'id source_type title category_id tags summary content source source_url attachment status'
      ).first
    end
  end

  def self.update_status params
    if params.blank? || params['id'].blank?
      return CommonException.new(ErrorCode::ERR_ARTICLE_PARAMS_ID_CAN_NOT_BE_BLANK).result
    end

    article = find_by(id: params['id'])
    unless article && article.enabled
      return CommonException.new(ErrorCode::ERR_ARTICLE_DOES_NOT_EXIT).result
    end
    Util.try_rescue do |response|
      update_params = {}
      case article.status
        when ArticleStatus::EDITING
          new_status = ArticleStatus::PUBLISHED
          update_params['pubdate'] = Time.now
        when ArticleStatus::PUBLISHED
          new_status = ArticleStatus::SOLD_OUT
        when ArticleStatus::SOLD_OUT
          new_status = ArticleStatus::PUBLISHED
      end
      update_params['status'] = new_status
      article.handle_update!(update_params)
    end
  end
end