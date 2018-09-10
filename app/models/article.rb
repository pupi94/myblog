class Article < ApplicationRecord
  include MarkdownTool
  include AASM

  validates :title, presence: true, length: { maximum: 64 }
  validates :summary, length: { maximum: 255 }

  belongs_to :label
  belongs_to :user

  aasm(:status) do
    state :opened, :initial => true
    state :published
    state :cancelled

    event :publish do
      transitions :from => :opened, :to => :published
    end

    event :cancel do
      transitions :from => :published, :to => :cancelled
    end
  end

  before_save :set_body_html
  def set_body_html
    self.body_html = convert_html(self.body)
  end

end


# DEFAULT_PAGE_SIZE = 15.freeze
# DEFAULT_PAGE = 1.freeze
# ARTICLE_PAGE_SIZE = 10

#
# module SidekiqQueue
#   CRITICAL = 'critical'
#   DEFAULT = 'default'
#   LOW = 'low'
# end