module Validates
  module UserValidate
    extend ModelValidate

    attr_validates do
      validates :email, presence: true, length: { maximum: 32 }, uniqueness: true
      validates :username, presence: true, length: { maximum: 32 }
    end
  end
end
