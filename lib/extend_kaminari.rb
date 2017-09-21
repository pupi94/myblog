module Kaminari
  module Helpers
    module HelperMethods
      # 复写paginate方法，在创建Paginator类时额外再传一个 total_count 参数
      def paginate(scope, paginator_class: Kaminari::Helpers::Paginator, template: nil, **options)
        options[:total_pages] ||= scope.total_pages
        options.reverse_merge! current_page: scope.current_page, per_page: scope.limit_value, total_count: scope.total_count, remote: false
        paginator = paginator_class.new (template || self), options
        paginator.to_s
      end
    end

    class Paginator
      # 打开PageProxy类并添加total_count方法获取 总数
      class PageProxy
        def total_count
          @options[:total_count]
        end
      end
    end
  end
end