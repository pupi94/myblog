# frozen_string_literal: true

class Api::Admin::CollectionsController < Api::AdminController
  before_action :load_collection, only: %i[publish show update unpublish destroy]

  def index
    collections = current_user.collections.includes(:articles)
    @count = collections.count
    @collections = paginate(collections)
  end

  def destroy
    @collection.destroy!
    render_ok
  end

  def show; end

  def update
    @collection.update!(collection_params)
    render_ok
  end

  def create
    @collection = current_user.collections.create!(collection_params)
    render_ok
  end

  private
    def collection_params
      params.require(:collection).permit(:title, :description, article_ids: [])
    end

    def load_collection
      @collection = current_user.collections.find(params[:id])
    end
end
