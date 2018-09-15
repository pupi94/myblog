class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 32 }, uniqueness: { case_sensitive: false }

  class ExitArticleError < StandardError ;end

  has_many :articles

  before_destroy :check_article
  def check_article
    raise ExitArticleError.new if self.articles.size > 0
  end
end
