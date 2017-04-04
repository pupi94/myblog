class TagsController < ApplicationController
  before_filter :login_required

  def create
    rtn = Tag.create(params)
    if Util.success? rtn
      search_rtn = Tag.search params
      @tags = search_rtn['tags'] || nil
      render "articles/tags_list"
      #render 'articles/shared/_tags_list', locals: { tags: tags }
    else
      render :json =>rtn
    end
  end

end