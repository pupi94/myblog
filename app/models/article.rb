class Article < ApplicationRecord
  validates_presence_of :title, message: ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK
  validates_presence_of :type, message: ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK
  validates_presence_of :category_id, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK
  validates_presence_of :tags, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK
  validates_presence_of :summary, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK
  validates_presence_of :author_id, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK
  validates_presence_of :author_name, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK
  validates_presence_of :author_name, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK

  validates :tags, length: { maximum: 32, message: ErrorCode::ERR_USER_NAME_THE_MAXIMUM_LENGTH_OF_32 }
  validates :password, length: { maximum: 64, message: ErrorCode::ERR_USER_PASSWORD_THE_MAXIMUM_LENGTH_OF_64 }
  validates :nickname, length: { maximum: 32, message: ErrorCode::ERR_USER_NICKNAME_THE_MAXIMUM_LENGTH_OF_32 }
end