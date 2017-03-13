class CategoriesController < ApplicationController
  layout :resolve_layout

  def index
  end

  def search
  end

  def create
    puts "========#{params}"
    #rtn = Category.create(params)
  end


  private
  def resolve_layout
    case action_name
    when 'index', 'search'
      'admin'
    else
      'application'
    end
  end
end