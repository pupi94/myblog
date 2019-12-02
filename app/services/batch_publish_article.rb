# frozen_string_literal: true

class BatchPublishArticle
  attr_reader :user, :article_ids

  def initialize(user, article_ids)
    @user = user
    @article_ids = article_ids
  end

  def call
    articles = user.articles.unpublished.where(id: article_ids)
    ids = articles.pluck(:id)

    articles.update_all(published: true, published_at: Time.zone.now)

    user.articles.where(id: ids).reindex
  end
end
