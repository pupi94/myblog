class ArticlesController < ApplicationController
  before_filter :login_required
  layout "cm_application"

  def index

  end

  def new
    tags_rtn = Tag.search params
    @tags = tags_rtn['tags'] || nil
    categories_rtn = Category.search({'enable' => true})
    @categories = categories_rtn['categories'] || nil
  end

  def create
  end

  def preview
    @article = params.slice(%w(source_type title content category tags summary source source_url))
    respond_to do |format|
      puts params
      format.html { 
        render "preview",
        layout: false
        # locals: {
        #   article: article,
        #   tags: tags,
        #   categories: categories
        # }
      }
    end
  end

end