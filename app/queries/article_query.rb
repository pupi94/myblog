class ArticleQuery
  def initialize(relation)
    #@relation = relation.all.extend(Scopes)
    @relation = relation.all
  end

  def search(params)
    # @relation = @relation.search_products_title(keywords_downcase(params[:keywords])) if params[:keywords].present?
    # @relation = @relation.with_products_type(params[:type]) if params[:type].present?
    # @relation =
    @relation = @relation.order(created_at: :desc)

  end

  private
  # def keywords_downcase(keywords)
  #   return "" if keywords.blank?
  #   keywords.downcase
  # end
  #
  # module Scopes
  #   def search_products_title(keywords)
  #     where("lower(products.title) LIKE ?", "%#{keywords}%")
  #   end
  #
  #   def with_products_type(type)
  #     if type == "normal"
  #       where("products.state != 'finished'")
  #     else
  #       where("products.state = 'finished'")
  #     end
  #   end
  # end

  # scope :enabled, -> { where(enabled: true) }
  # scope :disabled, -> { where(enabled: false) }
  #
  # scope :page_filter, ->(page_size, page) do
  #   page, page_size = page.to_i, page_size.to_i
  #   page = page < DEFAULT_PAGE ? DEFAULT_PAGE : page
  #   page_size = page_size <= 0 ? DEFAULT_PAGE_SIZE : page_size
  #
  #   limit(page_size).offset(page_size * (page - 1))
  # end

end