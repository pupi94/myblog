# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 255 }

  scope :published, -> { where(published: true) }
  scope :unpublished, -> { where(published: false) }

  searchkick searchable: [:title, :body],
    filterable: [:label_id, :user_id, :published],
    word_middle: [:title, :body],
    settings: { index: { max_result_window: 100000 } },
    language: "chinese"

  def search_data
    {
      user_id: user_id,
      title: title,
      content: content,
      published: published,
      created_at: created_at,
      published_at: published_at
    }
  end

  def publish!
    update!(published: true, published_at: Time.zone.now)
  end

  def unpublish!
    update!(published: false, published_at: false)
  end
end
