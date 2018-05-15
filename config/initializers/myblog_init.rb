include CustomConstant

require "extend_kaminari"

Log = Rails.logger
Log.level = Rails.logger.level

# 相关参数文档 http://www.rubydoc.info/gems/redcarpet/3.4.0
BlogMarkdown = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML,
#  no_intra_emphasis: true,
  fenced_code_blocks: true,
  disable_indented_code_blocks: true,
  strikethrough: true,#解析删除线
  lax_spacing:true,
  space_after_headers:true,
  superscript:true
)