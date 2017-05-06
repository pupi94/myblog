class Tag < ApplicationRecord
  validates_presence_of :name, message: ErrorCode::ERR_TAG_NAME_CANNOT_BE_BLANK

  validates :name, length: { maximum: 32, message: ErrorCode::ERR_TAG_NAME_THE_MAXIMUM_LENGTH_OF_32 }
 
  def self.create(params)
    Util.try_rescue do |response|
      if params['name'].blank?
        raise CommonException.new(ErrorCode::ERR_TAG_NAME_CANNOT_BE_BLANK)
      end
      if exists?(name: params['name'])
        raise CommonException.new(ErrorCode::ERR_TAG_NAME_NOT_UNIQUE)
      end
      handle_create(name: params['name'])
    end
  end

  def self.search(params)
    Util.try_rescue do |response|
      tags = all.select(%w(id name))
      response['tags'] = tags.as_json
    end
  end
end
