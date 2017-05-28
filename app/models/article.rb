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

  # validates_uniqueness_of :username, message: ErrorCode::ERR_USER_NAME_NOT_UNIQUE
  # validates_uniqueness_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_NOT_UNIQUE

  def self.login(params)
    Util.try_rescue do |response|
      if params['user_name'].blank?
        raise CommonException.new(ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK)
      end
      if params['password'].blank?
        raise CommonException.new(ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK)
      end
      password  = Digest::MD5.hexdigest(params['password'].encode('utf-8')).upcase
      user = find_by(username: params["user_name"], password: password)
      response['user'] = user
    end
  end

end