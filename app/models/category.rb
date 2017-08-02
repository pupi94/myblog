class Category < ApplicationRecord
  validates_presence_of :name, message: ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK
  validates_presence_of :seq, message: ErrorCode::ERR_CATEGORY_SEQ_CANNOT_BE_BLANK

  validates :name, length: { maximum: 32, message: ErrorCode::ERR_CATEGORY_NAME_THE_MAXIMUM_LENGTH_OF_32 }
 
  def self.create(params)
    Util.try_rescue do |response|
      if params['name'].blank?
        raise CommonException.new(ErrorCode::ERR_CATEGORY_NAME_CANNOT_BE_BLANK)
      end
      if exists?(name: params['name'])
        raise CommonException.new(ErrorCode::ERR_CATEGORY_NAME_NOT_UNIQUE)
      end
      seq = all.size
      create_params = params.slice(*['name'])
      create_params['seq'] = seq
      handle_create(create_params.to_hash)
    end
  end

  def self.search(params)
    Util.try_rescue do |response|
      categories = all
      if params['enabled'].present? && params['enabled']
        categories = categories.where(enabled: true)
      end
      categories = categories.order(seq: :asc).select(%w(id name enabled))
      response['categories'] = categories.as_json
    end
  end
end
