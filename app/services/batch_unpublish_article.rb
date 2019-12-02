# frozen_string_literal: true

class BatchUnpublishArticle
  attr_reader :user, :article_ids

  def initialize(user, article_ids)
    @user = user
    @article_ids = article_ids
  end

  def call
    articles = user.articles.published.where(id: article_ids)
    ids = articles.pluck(:id)

    articles.update_all(published: false, published_at: nil)

    user.articles.where(id: ids).reindex
  end
end
