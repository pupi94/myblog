module ApplicationHelper
  def show_status(status)
    if status
      return t 'common.enabled'
    else
      return t 'common.disabled'
    end
  end

  def format_date(date, format = '%Y-%m-%d %H:%M:%S')
    return nil if date.blank?
    date.to_time.strftime format
  end

  def article_source_type_select_options
    source_types = []
    SourceType.const_values.each do |value|
      source_types << [t("article.source_type.#{value}"), value]
    end
    options_for_select(source_types)
  end

  def article_category_select_options
    options = [['全部', '']]
    get_categories.each do |category|
      options << [category['name'], category['id']]
    end
    options_for_select(options)
  end

  def article_status_select_options
    options = [['全部', '']]
    ArticleStatus.const_values.each do |status|
      options << [t("article.status.#{status}"), status]
    end
    options_for_select(options)
  end


end
