Kaminari::Helpers::Paginator.class_eval do
  # 添加total_count方法获取 总数
  def total_count
    @options[:total_count]
  end

  def show_total_count?
    @options[:show_total_count]
  end
end