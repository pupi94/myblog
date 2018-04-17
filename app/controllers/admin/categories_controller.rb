module Admin
  class CategoriesController < ApplicationController
    layout 'admin'

    def index
      @categories = Category.all.order(seq: :asc)
    end

    def create
      category = Category.create!(name: params['name'])
      render :json => {'return_code' => 0, 'id' => category.id}
    end
  end
end