class Category < ApplicationRecord
  include Validates::CategoryValidate

  has_many :articles

  default_scope { order(seq: :asc) }

  before_validation :set_seq
  def set_seq
    self.seq = Category.maximum(:seq).to_i + 1 if self.seq.nil?
  end

  after_save :clear_cache
  after_destroy :clear_cache
  def clear_cache
    Rails.cache.write('categories', nil)
    Rails.cache.write('categories_hash', nil)
    Rails.cache.write('categories_en_name_hash', nil)
    Rails.cache.write('en_names', nil)
  end

  def move_up
    previous = self.class.where(seq: self.seq - 1).first
    fail CustomError.new 'category.error.last' if previous.nil?
    previous.update_columns(seq: self.seq)
    self.update_columns(seq: self.seq - 1)
    clear_cache
  end

  def move_down
    next_c = self.class.where(seq: self.seq + 1).first
    fail CustomError.new 'category.error.last' if next_c.nil?
    next_c.update_columns(seq: self.seq)
    self.update_columns(seq: self.seq + 1)
    clear_cache
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
