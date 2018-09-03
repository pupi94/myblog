module Admin
  class LabelsController < ::AdminController

    def index
      #@categories = Category.all
    end

    def create
      #Category.create!(name: params['name'], name_en: params[:name_en])
      #render :json => success_json
    end

    def update
      # category = Category.find(params[:id])
      # category.name = params[:name]
      # category.name_en = params[:name_en]
      # category.save
      # render :json => success_json
    end

    def destroy
      # category = Category.find(params['id'])
      # begin
      #   category.destroy
      # rescue Exception => e
      #   flash[:error_msg] = I18n.t('category.error.destroy')
      #   Log.error(e)
      # end
      # redirect_to admin_categories_path
    end
  end
end