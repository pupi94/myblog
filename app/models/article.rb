class Article < ApplicationRecord
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
      handle_create(create_params)
    end
  end

  def self.search(params)
    Util.try_rescue do |response|
      search_column = %w(title source_type category_id tags summary content author_name pv pubdate status)
      articles = all
      response['total_count'] = articles.size
      Util.check_paging_params(params)
      articles = articles.limit(params['page_size']).offset(params['page_size'] * params['page_no'])
      response['articles'] = articles.select(*search_column).as_json
    end
  end
end