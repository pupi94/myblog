module Validates
  module ArticleValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :title,       message: ErrorCode::ERR_ARTICLE_TITLE_CANNOT_BE_BLANK
      validates_presence_of :source_type, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_CANNOT_BE_BLANK
      validates_presence_of :category_id, message: ErrorCode::ERR_ARTICLE_CATEGORY_ID_CANNOT_BE_BLANK
      validates_presence_of :tags,        message: ErrorCode::ERR_ARTICLE_TAGS_CANNOT_BE_BLANK
      validates_presence_of :author_id,   message: ErrorCode::ERR_ARTICLE_AUTHOR_ID_CANNOT_BE_BLANK
      validates_presence_of :author_name, message: ErrorCode::ERR_ARTICLE_AUTHOR_NAME_CANNOT_BE_BLANK

      validates :title,      length: { maximum: 64, message: ErrorCode::ERR_ARTICLE_TITLE_THE_MAXIMUM_LENGTH_OF_64 }
      validates :source,     length: { maximum: 64, message: ErrorCode::ERR_ARTICLE_SOURCE_THE_MAXIMUM_LENGTH_OF_64 }
      validates :source_url, length: { maximum: 128, message: ErrorCode::ERR_ARTICLE_SOURCE_URL_THE_MAXIMUM_LENGTH_OF_128 }
      validates :summary,    length: { maximum: 255, message: ErrorCode::ERR_ARTICLE_SUMMARY_THE_MAXIMUM_LENGTH_OF_255 }

      validates(:tags,
        length: { maximum: 64,  message: ErrorCode::ERR_ARTICLE_TAGS_THE_MAXIMUM_LENGTH_OF_64 },
        format: { with: /\A([-a-zA-Z\u4E00-\u9FFF\s](,)?)+\Z/, message: ErrorCode::ERR_ARTICLE_TAGS_INVALID }
      )

      validates :source_type,  inclusion: {in: SourceType.const_values, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_INVALID}
      validates :status,    inclusion: {in: ArticleStatus.const_values, message: ErrorCode::ERR_ARTICLE_STATUS_INVALID}
    end
  end
end
