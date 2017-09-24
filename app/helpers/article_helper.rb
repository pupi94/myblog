module ArticleHelper

  def article_source_type_select_options  value = nil
    source_types = []
    SourceType.const_values.each do |value|
      source_types << [t("article.source_type.#{value}"), value]
    end
    options_for_select(source_types, value)
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

  def get_categories
    categories = Rails.cache.read("categories")
    if categories.nil?
      rtn  = Category.search({'enabled' => true})
      categories = rtn['categories']
      Rails.cache.write("categories", categories)
    end
    categories
  end
end
