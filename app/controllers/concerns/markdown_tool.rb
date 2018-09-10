module MarkdownTool
  extend ActiveSupport::Concern

  def convert_html(text)
    #text.blank? ? nil : BlogMarkdown.render(text)
  end
end