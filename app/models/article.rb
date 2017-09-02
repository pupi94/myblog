class Article < ApplicationRecord
  validates_presence_of :title, message: ErrorCode::ERR_ARTICLE_TITLE_CANNOT_BE_BLANK
  validates_presence_of :source_type, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_CANNOT_BE_BLANK
  validates_presence_of :category_id, message: ErrorCode::ERR_ARTICLE_CATEGORY_ID_CANNOT_BE_BLANK
  validates_presence_of :tags, message: ErrorCode::ERR_ARTICLE_TAGS_CANNOT_BE_BLANK

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
      create_params = params.slice(
        *%w'source_type title category_id tags summary content source source_url attachment author_id author_name'
      )
      handle_create(create_params)
    end
  end
end