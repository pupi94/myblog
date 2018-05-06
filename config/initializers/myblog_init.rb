include CustomConstant

require "extend_kaminari"

Log = Rails.logger
Log.level = Rails.logger.level

# 相关参数文档 http://www.rubydoc.info/gems/redcarpet/3.4.0
BlogMarkdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
