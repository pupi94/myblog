module Admin
  class CategoriesController < ApplicationController

    def index
      rtn = Category.search({})
      if Util.success? rtn
        @categories = rtn['categories']
      else
        @msg = rtn['return_info']
      end
    end

    def create
      rtn = Category.create(params)
      render :json =>rtn
    end
  end
end