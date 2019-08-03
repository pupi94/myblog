# frozen_string_literal: true

module Admin
  class MarkdownController < ::AdminController
    include MarkdownHelper

    def convert_html
      result = { 'return_code' => SUCCESS_CODE, 'content' => '' }
      result['content'] = super(params['content'])
      render json: result
    end
  end
end
