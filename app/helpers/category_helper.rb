module CategoryHelper

  def category_select_options category = nil
    options = categories_cache.reduce([['全部', '']]) do |opts, category|
      opts << [category['name'], category['id']]
    end
    options_for_select(options, category)
  end

  def categories_cache
    Rails.cache.fetch('categories') do
      Category.enabled.select(%w[id name name_en]).as_json
    end
  end

  def categories_hash_cache
    Rails.cache.fetch('categories_hash') do
      categories_cache.reduce({})do |categories_hash, category|
        categories_hash[category['id'].to_s] = category
        categories_hash
      end
    end
  end

  def categories_en_name_hash
    Rails.cache.fetch('categories_en_name_hash') do
      categories_cache.reduce({}) do |en_name_hash, category|
        en_name_hash[category['name_en']] = {'id' => category['id'], 'name' => category['name']}
        en_name_hash
      end
    end
  end
end