# frozen_string_literal: true

class ArticleQuery
  attr_reader :params, :user

  def initialize(params)
    @params = params
  end

  def query
    Article.search keyword,
      operator: "or",
      fields: ["title^10", "body"],
      match: :word_middle,
      where: where_clause,
      order: order_clause,
      per_page: per_page,
      page: page,
      includes: [:label],
      body_options: { min_score: 0.5 }
  end

  private
    def keyword
      params[:wd].present? ? CGI.unescape(params[:wd]) : "*"
    end

    def where_clause
      { published: true }
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
        { published_at: :desc }
      ]
    end
end
