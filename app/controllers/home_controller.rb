# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @articles = Article.published.order(published_at: :desc).limit(10)
  end
end
