include CustomConstant

require_relative "../../lib/extend_kaminari"

Log = Rails.logger
Log.level = Rails.logger.level

Markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
