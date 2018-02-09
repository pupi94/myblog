module CategoryHelper
  def get_category_hash
    category_hash = Rails.cache.read("category_hash")
    if category_hash.nil?
      rtn  = Category.search({'enabled' => true})
      categories = rtn['categories']
      category_hash = {}
      categories.each do |category|
        category_hash[category['id'].to_s] = category
      end
      Rails.cache.write("category_hash", category_hash)
    end
    category_hash
  end

  def get_category_name category_id
    category_hash = get_category_hash
    category_hash[category_id.to_s]
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

  def category_select_options category = nil
    options = [['全部', '']]
    get_categories.each do |category|
      options << [category['name'], category['id']]
    end
    options_for_select(options, category)
  end
end