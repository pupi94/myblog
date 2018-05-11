class Notice < ApplicationRecord
  validates_presence_of :content, message: 'notice.error.content_blank'

  validates :content, length: { maximum: 128, message: 'notice.error.content_length_over_128' }
end