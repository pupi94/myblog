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
  end
end
