# frozen_string_literal: true

class ArticleQuery
  attr_reader :params, :user

  def initialize(params)
    @params = params
  end

  def query
    Article.search keyword,
      operator: "or",
      fields: ["title^10", "content"],
      match: :word_middle,
      where: where_clause,
      order: order_clause,
      per_page: per_page,
      page: page,
      body_options: { min_score: 0.5 }
  end

  private
    def keyword
      params[:wd].present? ? CGI.unescape(params[:wd]) : "*"
    end

    def where_clause
      { published: true }.tap do |clause|
        clause[:collection_ids] = params[:collection] if params[:collection].present?
      end
    end

    def per_page
      params[:per_page].present? ? params[:per_page] : 10
    end

    def page
      params[:page].present? ? params[:page] : 1
    end

    def order_clause
      [
        { _score: :desc },
        { created_at: :desc }
      ]
    end
end
