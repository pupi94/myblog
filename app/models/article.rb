class Article < ApplicationRecord
  include MarkdownHelper
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
      before { self.pubdate = Time.current }
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