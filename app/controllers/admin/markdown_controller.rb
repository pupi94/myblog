# frozen_string_literal: true

module Admin
  class MarkdownController < ::AdminController
    include MarkdownHelper

    def convert_html
      render json: { content: super(params["content"]) }
    end
  end
end
