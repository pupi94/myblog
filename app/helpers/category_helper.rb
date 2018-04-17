module CategoryHelper

  def category_select_options category = nil
    options = categories.reduce([['全部', '']]) do |opts, category|
      opts << [category['name'], category['id']]
    end
    options_for_select(options, category)
  end

  def category_name category_id
    category_hash = category_hash_cache
    category_hash[category_id.to_s]
  end

  def categories_cache
    categories = Rails.cache.read("categories")
    if categories.nil?
      categories = Category.enabled
      Rails.cache.write("categories", categories)
    end
    categories
  end

  def category_hash_cache
    category_hash = Rails.cache.read("category_hash")
    if category_hash.nil?
      category_hash = {}
      categories.each do |category|
        category_hash[category['id'].to_s] = category
      end
      Rails.cache.write("category_hash", category_hash)
    end
    category_hash
  end

  def categories
    Category.enabled.select(%w[id name])
  end
end