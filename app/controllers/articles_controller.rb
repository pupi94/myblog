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
    article = params.slice(*%w(source_type title content category tags summary source source_url))
  end

  def preview
    article = params.slice(*%w(source_type title content category tags summary source source_url))
    puts '=================='
    puts article
    respond_to do |format|
      format.html { 
        render "preview",
        layout: false,
        locals: {
          article: article
        }
      }
    end
  end

end