module Validates
  module UserValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :username, message: ErrorCode::ERR_USER_NAME_CANNOT_BE_BLANK
      validates_presence_of :password, message: ErrorCode::ERR_USER_PASSWORD_CANNOT_BE_BLANK
      validates_presence_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_CANNOT_BE_BLANK

      validates :username, length: { maximum: 32, message: ErrorCode::ERR_USER_NAME_THE_MAXIMUM_LENGTH_OF_32 }
      validates :password, length: { maximum: 64, message: ErrorCode::ERR_USER_PASSWORD_THE_MAXIMUM_LENGTH_OF_64 }
      validates :nickname, length: { maximum: 32, message: ErrorCode::ERR_USER_NICKNAME_THE_MAXIMUM_LENGTH_OF_32 }

      # validates_uniqueness_of :username, message: ErrorCode::ERR_USER_NAME_NOT_UNIQUE
      # validates_uniqueness_of :nickname, message: ErrorCode::ERR_USER_NICKNAME_NOT_UNIQUE
    end
  end
end
