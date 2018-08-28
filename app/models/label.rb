class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 32 }, uniqueness: { case_sensitive: false }

  has_many :articles
end
