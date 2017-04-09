module ApplicationHelper
  def show_status(status)
    if status
      return t 'common.enable'
    else
      return t 'common.disable'
    end
  end

  def show_article_source_type_select
    source_types = []
    ArticleSourceType.const_values.each do |value|
      source_types << [t("article.#{value}"), value]
    end
    options_for_select(source_types)
  end
end
