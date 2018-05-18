module CategoryHelper

  def category_select_options category = nil
    options = categories_cache.reduce([['全部', '']]) do |opts, category|
      opts << [category['name'], category['id']]
    end
    options_for_select(options, category)
  end

  def categories_cache
    categories = Rails.cache.read("categories")
    if categories.nil?
      categories = Category.enabled.select(%w[id name name_en]).as_json
      Rails.cache.write("categories", categories)
    end
    categories
  end

  def categories_hash_cache
    categories_hash = Rails.cache.read("categories_hash")
    if categories_hash.nil?
      categories_hash = {}
      categories_cache.each do |category|
        categories_hash[category['id'].to_s] = category
      end
      Rails.cache.write("categories_hash", categories_hash)
    end
    categories_hash
  end

  def categories_en_name_hash
    hash = Rails.cache.read('categories_en_name_hash')
    if hash.nil?
      hash = {}
      categories_cache.each do |category|
        hash[category['name_en']] = {'id' => category['id'], 'name' => category['name']}
      end
      Rails.cache.write('categories_en_name_hash', hash)
    end
    hash
  end
end