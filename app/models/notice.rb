class Notice < ApplicationRecord
  validates_presence_of :content

  validates :content, length: { maximum: 128 }
end