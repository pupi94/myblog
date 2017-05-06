class TagsController < ApplicationController
  before_filter :login_required

  def create
    rtn = Tag.create(params)
    search_rtn = Tag.search params
    @tags = search_rtn['tags'] || nil
    render "articles/tags_checkbox_list"
  end

end