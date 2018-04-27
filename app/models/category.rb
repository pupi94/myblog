class Category < ApplicationRecord
  include Validates::CategoryValidate

  has_many :articles

  before_validation :set_seq
  def set_seq
    self.seq = Category.maximum(:seq).to_i + 1 if self.seq.nil?
  end

  after_save :clear_cache
  def clear_cache
    Rails.cache.write('categories', nil)
    Rails.cache.write('category_hash', nil)
    Rails.cache.write('categories_name_en_hash', nil)
    Rails.cache.write('name_en_list', nil)
  end

  class << self
    def name_en_list
      list = Rails.cache.read('name_en_list')
      if list.nil?
        list = self.enabled.pluck(:name_en)
        Rails.cache.write('name_en_list', list)
      end
      list
    end
  end
end
