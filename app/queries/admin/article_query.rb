# frozen_string_literal: true

module Admin
  class ArticleQuery
    using StringExtensions

    attr_reader :params, :user

    def initialize(user, params)
      @user = user
      @params = params
    end

    def query
      Article.search keyword,
        operator: "or",
        fields: ["title^10"],
        match: :word_middle,
        where: where_clause,
        order: order_clause,
        per_page: per_page,
        page: page,
        body_options: { min_score: 0.5 }
    end

    private
      def keyword
        params[:keyword].present? ? CGI.unescape(params[:keyword]) : "*"
      end

      def where_clause
        clause = { user_id: user.id }
        clause[:published] = params[:published] if params[:published].to_s.present?
        clause
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
end
