# frozen_string_literal: true

module Admin
  class LabelsController < ::AdminController
    before_action :load_label, only: [:destroy]
    protect_from_forgery except: [:create]

    def index
      @labels = Label.all
    end

    def create
      @label = Label.new(name: params[:name])
      flash[:alert] = @label.errors.full_messages.first unless @label.save
      redirect_to admin_labels_path
    end

    def destroy
      @label.destroy!
      redirect_to admin_labels_path
    rescue Label::ExitArticleError
      flash[:alert] = I18n.t('error.article_exit')
      redirect_to admin_labels_path
    end

    private

    def load_label
      @label = Label.find(params[:id])
    end
  end
end
