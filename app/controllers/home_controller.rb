# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @articles = ArticleQuery.new(per_page: 10).query
  end
end
