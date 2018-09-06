module Admin
  class LabelsController < ::AdminController

    def index
      #@categories = Category.all
    end

    def create
      @label = Label.new(name: params[:name])
      flash[:alert] = @label.errors.full_messages.first unless @label.save
      redirect_to admin_labels_path
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