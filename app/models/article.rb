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

  validates :source_type,  inclusion: {in: SourceType.const_values, message: ErrorCode::ERR_ARTICLE_SOURCE_TYPE_INVALID.to_s}
  validates :status,  inclusion: {in: ArticleStatus.const_values, message: ErrorCode::ERR_ARTICLE_STATUS_INVALID.to_s}

  def self.create(params)
    #"source_type"=>"original", "title"=>"是大法官第三方", "category"=>"1", "tags"=>["1"], "summary"=>"是大法官的双方各", "content"=>"第三方赶得上发个", "source"=>"", "source_ures",

  end
end