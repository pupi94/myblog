class Category < ApplicationRecord
  include Validates::CategoryValidate

  has_many :articles
 
  def self.create(params)
    Util.try_rescue do |response|
      return CommonException.new(ErrorCode::ERR_CATEGORY_NAME_NOT_UNIQUE).result if exists?(name: params['name'])
      params['seq'] = all.size
      handle_create(params.to_unsafe_h)
    end
  end

  def self.search(params)
    Util.try_rescue do |response|
      categories = all
      categories = categories.where(enabled: params['enabled']) if params.has_key?('enabled')
      response['categories'] = categories.order(seq: :asc).select(%w(id name enabled))
    end
  end
end
