class Article < ApplicationRecord
  include MarkdownTool

  validates :title, presence: true, length: { maximum: 64 }
  validates :summary, length: { maximum: 255 }

  belongs_to :label
  belongs_to :user

  before_save :set_body_html
  def set_body_html
    self.body_html = convert_html(self.body)
  end

end


# DEFAULT_PAGE_SIZE = 15.freeze
# DEFAULT_PAGE = 1.freeze
# ARTICLE_PAGE_SIZE = 10
#
# module ArticleStatus
#   extend ConstantValue
#
#   EDITING = "editing".freeze
#   PUBLISHED = "published".freeze
# end
#
# module BlogLayout
#   DEVISE = 'devise'.freeze
#   ADMIN = 'admin'.freeze
#   APPLICATION = 'application'.freeze
# end
#
# module SidekiqQueue
#   CRITICAL = 'critical'
#   DEFAULT = 'default'
#   LOW = 'low'
# end