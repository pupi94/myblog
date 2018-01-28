class User < ApplicationRecord
  validates_presence_of :username, message: ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK
  validates_presence_of :password, message: ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK
  validates_presence_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK

  validates :username, length: { maximum: 32, message: ErrorCode::ERR_USER_NAME_THE_MAXIMUM_LENGTH_OF_32 }
  validates :password, length: { maximum: 64, message: ErrorCode::ERR_USER_PASSWORD_THE_MAXIMUM_LENGTH_OF_64 }
  validates :nickname, length: { maximum: 32, message: ErrorCode::ERR_USER_NICKNAME_THE_MAXIMUM_LENGTH_OF_32 }

  # validates_uniqueness_of :username, message: ErrorCode::ERR_USER_NAME_NOT_UNIQUE
  # validates_uniqueness_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_NOT_UNIQUE

  def self.login(params)
    if params['user_name'].blank?
      return CommonException.new(ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK)
    end
    if params['password'].blank?
      return CommonException.new(ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK)
    end
    Util.try_rescue do |response|
      password  = Digest::MD5.hexdigest(params['password'].encode('utf-8')).upcase
      user = find_by(username: params["user_name"], password: password)
      fail CommonException.new(ErrorCode::ERR_USER_PASSWORD_OR_NMAE_WRONG) unless user
      response['user'] = user
    end
  end
end
