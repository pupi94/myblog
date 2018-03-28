class User < ApplicationRecord
  include Validates::UserValidate

  def self.login(params)
    return CommonException.new(ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK).result if params['user_name'].blank?
    return CommonException.new(ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK).result if params['password'].blank?

    Util.try_rescue do |response|
      password  = Digest::MD5.hexdigest(params['password'].encode('utf-8')).upcase
      user = find_by(username: params["user_name"], password: password)
      return CommonException.new(ErrorCode::ERR_USER_PASSWORD_OR_NMAE_WRONG).result unless user
      response['user'] = user
    end
  end

  def self.init_superadmin
    User.create!({
      username: "superadmin",
      password: Digest::MD5.hexdigest("hpp1221802".encode('utf-8')).upcase,
      nickname: "黄谱平"
    })
  end
end
