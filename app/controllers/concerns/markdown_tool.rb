module MarkdownTool
  extend ActiveSupport::Concern

  def convert_html(text)
    return nil if text.blank?
    BlogMarkdown.render(text)
  end

  module ClassMethods

  end
end