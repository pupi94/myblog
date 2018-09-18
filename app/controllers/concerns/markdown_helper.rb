module MarkdownHelper
  extend ActiveSupport::Concern

  def convert_html(text)
    text.blank? ? nil : markdown.render(text)
  end

  def markdown
    Redcarpet::Markdown.new(
      Redcarpet::Render::HTML,
      # no_intra_emphasis: true,
      fenced_code_blocks: true,
      disable_indented_code_blocks: true,
      strikethrough: true, # 解析删除线
      lax_spacing:true,
      space_after_headers:true,
      superscript:true
    )
  end
end