module Validates
  module UserValidate
    extend ModelValidate

    attr_validates do
      validates_presence_of :username, message: 'user.error.name_blank'
      validates_presence_of :password, message: 'user.error.name_length_over_32'
      validates_presence_of :nickname, message: 'user.error.password_blank'

      validates(
        :username,
        length: { maximum: 32, message: 'user.error.password_length_over_64' },
        uniqueness: { message: 'user.error.name_not_unique' },
      )
      validates :password, length: { maximum: 64, message: 'user.error.nickname_blank' }
      validates(
        :nickname,
        length: { maximum: 32, message: 'user.error.nickname_length_over_32' },
        uniqueness: { message: 'user.error.nickname_not_unique' }
      )
    end
  end
end
