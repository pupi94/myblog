# frozen_string_literal: true

class UpdateArticle
  attr_reader :article, :params, :collection_ids

  def initialize(article, params)
    @article = article
    @collection_ids = params.delete(:collection_ids) || []
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      article.update!(params)
      refresh_collection_articles
    end
    article
  end

  private
    def refresh_collection_articles
      delete_collection_articles
      create_collection_articles
    end

    def delete_collection_articles
      removed_collection_ids = old_collection_ids - collection_ids
      return if removed_collection_ids.blank?
      article.collection_articles.where(collection_id: removed_collection_ids).delete_all
    end

    def create_collection_articles
      return if added_collection_ids.blank?
      insert_params = added_collection_ids.map do |collection_id|
        {
          article_id: article.id,
          collection_id: collection_id,
          position: (max_position_map[collection_id] || 0) + 1,
          created_at: time_now,
          updated_at: time_now
        }
      end
      CollectionArticle.insert_all!(insert_params)
    end

    def old_collection_ids
      @old_collection_ids ||= article.collection_articles.pluck(:collection_id)
    end

    def added_collection_ids
      @added_collection_ids ||= collection_ids - old_collection_ids
    end

    def max_position_map
      @max_position_map ||= begin
        collections = user.collections.where(id: added_collection_ids)
                        .joins(:collection_articles)
                        .group("collections.id")
                        .select("collections.id, max(collection_articles.position) AS max_position")

        collections.reduce({}) do |map, record|
          map.tap { |m| m[record.id] = record.max_position }
        end
      end
    end

    def time_now
      @time_now ||= Time.zone.now
    end

    def user
      @user ||= article.user
    end
end
