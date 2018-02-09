module ArticleHelper

  def article_source_type_select_options
    source_types = []
    SourceType.const_values.each do |value|
      source_types << [t("article.source_type.#{value}"), value]
    end
    options_for_select(source_types)
  end

  def article_status_select_options
    options = [['全部', '']]
    ArticleStatus.const_values.each do |status|
      options << [t("article.status.#{status}"), status]
    end
    options_for_select(options)
  end
end
