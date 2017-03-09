class User < ActiveRecord::Base
  validates_presence_of :username, message: ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK.to_s
  validates_presence_of :password, message: ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK.to_s
  validates_presence_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK.to_s

  validates :username, length: { maximum: 32, message: ErrorCode::ERR_USER_NAME_THE_MAXIMUM_LENGTH_OF_32.to_s }
  validates :password, length: { maximum: 25, message: ErrorCode::ERR_USER_PASSWORD_THE_MAXIMUM_LENGTH_OF_64.to_s }
  validates :nickname, length: { maximum: 32, message: ErrorCode::ERR_USER_NICKNAME_THE_MAXIMUM_LENGTH_OF_32.to_s }

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