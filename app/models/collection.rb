# frozen_string_literal: true

class Collection < ApplicationRecord
  belongs_to :user
  has_many :collection_articles, -> { order(position: :asc) }, dependent: :destroy
  has_many :articles, through: :collection_articles

  validates :name, presence: true, length: { maximum: 30 }
end
