module Validates
  module CategoryValidate
    include ModelValidate

    attr_validates {
      validates_presence_of :name, message: ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK
      validates_presence_of :seq, message: ErrorCode::ERR_CATEGORY_SEQ_CANNOT_BE_BLANK

      validates :name, length: { maximum: 32, message: ErrorCode::ERR_CATEGORY_NAME_THE_MAXIMUM_LENGTH_OF_32 }
    }
  end
end
