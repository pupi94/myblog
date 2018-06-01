module Admin
  class CategoriesController < ApplicationController
    layout BlogLayout::ADMIN

    def index
      @categories = Category.all.order(seq: :asc)
    end

    def create
      Category.create!(name: params['name'], name_en: params[:name_en])
      render :json => success_json
    end

    def update
      category = Category.find(params[:id])
      category.name = params[:name]
      category.name_en = params[:name_en]
      category.save
      render :json => success_json
    end
  end
end