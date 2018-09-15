module ArticleHelper
  def label_options
    options = Label.all.reduce([[t("label.all"), '']]) do |options, label|
      options << [label.name, label.id]
    end
    options_for_select(options)
  end

  def article_status_options
    options = %w[opened published cancelled].reduce([[t("article.status.all"), '']]) do |opts, status|
      opts << [I18n.t("article.status.#{status}"), status]
    end
    options_for_select(options)
  end

  def hot_articles
    Article.published.order(pv: :desc, pubdate: :desc).limit(8).select(%w[id title pubdate])
  end
end
