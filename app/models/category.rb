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
    Rails.cache.write('categories_hash', nil)
    Rails.cache.write('categories_name_en_hash', nil)
    Rails.cache.write('en_names', nil)
  end

  class << self
    def en_names
      list = Rails.cache.read('en_names')
      if list.nil?
        list = self.enabled.pluck(:name_en)
        Rails.cache.write('en_names', list)
      end
      list
    end
  end
end
