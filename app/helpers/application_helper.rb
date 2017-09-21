module ApplicationHelper
  def show_status(status)
    if status
      return t 'common.enabled'
    else
      return t 'common.disabled'
    end
  end

  def show_article_source_type_select
    source_types = []
    SourceType.const_values.each do |value|
      source_types << [t("article.source_type.#{value}"), value]
    end
    options_for_select(source_types)
  end

  def format_date(date, format = '%Y-%m-%d %H:%M:%S')
    return nil if date.blank?
    date.to_time.strftime format
  end
end
