module ArticleHelper
  def article_source_type_select_options
    options_for_select(
      SourceType.const_values.reduce([]) do |source_types, value|
        source_types << [I18n.t("article.source_type.#{value}"), value]
      end
    )
  end

  def article_status_select_options
    options = ArticleStatus.const_values.reduce([['全部', '']]) do |opts, status|
      opts << [I18n.t("article.status.#{status}"), status]
    end
    options_for_select(options)
  end
end
