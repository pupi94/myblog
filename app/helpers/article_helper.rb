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

  def common_tags
    tags = Rails.cache.read('common_tags')
    if tags.nil?
      tags = Article.common_tags
      Rails.cache.write('common_tags', tags)
    end
    tags
  end
end
