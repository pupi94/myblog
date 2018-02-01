include CustomConstant

require_relative "../../lib/extend_kaminari"

Log = Rails.logger
Log.level = Rails.logger.level

# 先关参数文档 http://www.rubydoc.info/gems/redcarpet/3.4.0
Markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
