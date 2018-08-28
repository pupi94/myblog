class Article < ApplicationRecord
  include MarkdownTool

  validates :title, presence: true, length: { maximum: 64 }
  validates :summary, length: { maximum: 255 }

  belongs_to :label
  belongs_to :user

  before_save :update_body_html
  def update_content_html
    self.body_html = convert_html(self.body)
  end

end