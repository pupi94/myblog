module Kaminari::Helpers
  Paginator.class_eval do
    # 添加total_count方法获取 总数
    def total_count
      @options[:total_count]
    end

    def show_total_count?
      @options[:show_total_count].nil? ? true : @options[:show_total_count]
    end
  end

  HelperMethods.module_eval do
    def paginate(scope, paginator_class: Kaminari::Helpers::Paginator, template: nil, **options)
      options[:total_pages] ||= scope.total_pages
      options.reverse_merge!(
        current_page: scope.current_page,
        per_page: scope.limit_value,
        total_count: scope.total_count,
        remote: false
      )

      paginator = paginator_class.new (template || self), options
      paginator.to_s
    end
  end
end

Kaminari::PaginatableArray.class_eval do
  def has_values?
    total_count > 0
  end
end