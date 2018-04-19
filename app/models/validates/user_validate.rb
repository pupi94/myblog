module Validates
  module UserValidate
    extend ModelValidate

    attr_validates do
      validates :email,
        presence:   {message: 'user.error.email_blank'},
        length:     { maximum: 32, message: 'user.error.email_length_over_32' },
        uniqueness: { message: 'user.error.name_not_unique' }

      validates :username,
        presence:   {message: 'user.error.name_blank'},
        length: { maximum: 32, message: 'user.error.name_length_over_32' }
    end
  end
end
