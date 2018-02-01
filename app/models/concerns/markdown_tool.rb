module MarkdownTool
  extend ActiveSupport::Concern

  module ClassMethods
    def convert_html(text)
      return nil if text.blank?
      Markdown.render(text)
    end
  end
end