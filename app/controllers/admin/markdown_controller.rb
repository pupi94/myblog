class MarkdownController < ApplicationController
  include MarkdownTool

  def convert_html
    result = {'return_code' => 0, 'content' => '0'}
    result['content'] = super(params['content'])
    render json: result
  end
end