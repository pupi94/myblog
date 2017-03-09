class Category < ActiveRecord::Base
  validates_presence_of :name, message: ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK.to_s
  validates_presence_of :sequence, message: ErrorCode::ERR_CATEGORY_SEQUENCE_CANNOT_BE_BLANK.to_s

  validates :name, length: { maximum: 32, message: ErrorCode::ERR_CATEGORY_NAME_THE_MAXIMUM_LENGTH_OF_32.to_s }
 
  def self.create(params)
    Util.try_rescue do |response|
      transaction do
        if params['name'].blank?
          raise CommonException.new(ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK)
        end
        sequence = all.size
        create_params = params.slice(['name'])
        create_params['sequence'] = sequence
        handle_create!(create_params)
      end
    end
  end
end
