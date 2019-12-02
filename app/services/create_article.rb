# frozen_string_literal: true

class CreateArticle
  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @collection_ids = params.delete(:collection_ids) || []
    @params = params
  end

  def call
    ActiveRecord::Base.transaction do
      @article = store.articles.create!(params)
      create_collection_articles if collection_ids.present?
    end
    @article
  end

  private
    def max_position_map
      @max_position_map ||= begin
        collections = user.collections.where(id: collection_ids)
                        .joins(:collection_articles)
                        .group("collections.id")
                        .select("collections.id, max(collection_articles.position) AS max_position")

        collections.reduce({}) do |map, record|
          map.tap { |m| m[record.id] = record.max_position }
        end
      end
    end

    def create_collection_articles
      insert_params = collection_ids.map do |collection_id|
        {
          article_id: @article.id,
          collection_id: collection_id,
          position: (max_position_map[collection_id] || 0) + 1,
          created_at: time_now,
          updated_at: time_now
        }
      end
      CollectionArticle.insert_all!(insert_params)
    end

    def time_now
      @time_now ||= Time.zone.now
    end
end
