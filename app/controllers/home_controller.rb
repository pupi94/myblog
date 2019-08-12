# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @articles = ArticleQuery.new({ per_page: 8 }).query
  end
end
