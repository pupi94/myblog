class Article < ApplicationRecord
  include MarkdownHelper
  include AASM

  validates :title, presence: true, length: { maximum: 255 }

  belongs_to :label
  belongs_to :user

  scope :published, ->{ where(published: true) }

  before_save :set_body_html
  def set_body_html
    self.body_html = convert_html(self.body)
  end

  def publish!
    update!(published: true, published_at: Time.zone.now)
  end

  def unpublish!
    update!(published: false, published_at: false)
  end
end