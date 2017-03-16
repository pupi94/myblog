class Category < ApplicationRecord
  validates_presence_of :name, message: ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK
  validates_presence_of :seq, message: ErrorCode::ERR_CATEGORY_SEQ_CANNOT_BE_BLANK

  validates :name, length: { maximum: 32, message: ErrorCode::ERR_CATEGORY_NAME_THE_MAXIMUM_LENGTH_OF_32 }
  validates_uniqueness_of :name, message: ErrorCode::ERR_CATEGORY_NAME_NOT_UNIQUE
 
  def self.create(params)
    Util.try_rescue do |response|
      transaction do
        if params['name'].blank?
          raise CommonException.new(ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK)
        end
        seq = all.size
        create_params = params.slice(['name'])
        create_params['seq'] = seq
        handle_create!(create_params)
      end
    end
  end
end
