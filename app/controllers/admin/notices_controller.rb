module Admin
  class NoticesController < ApplicationController

    def create
      Notice.create!(content: params['content'])
      render :json => success_json
    end

    def index
      @notices = Notice.order(created_at: :desc)
    end

    def destroy
      Notice.find(params[:id]).destroy!
      render :json => success_json
    end
  end
end
