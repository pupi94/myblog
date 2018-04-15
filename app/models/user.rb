class User < ApplicationRecord
  include Validates::UserValidate

  class << self
    def login(user_name, password)
      password  = Digest::MD5.hexdigest(password.encode('utf-8')).upcase
      find_by(username: user_name, password: password)
    end
  end
end
