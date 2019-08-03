module ArticleHelper
  def label_options(with_all: true)
    options = with_all ? [[t("label.all"), '']] : []
    Label.all.each do |label|
      options << [label.name, label.id]
    end
    options_for_select(options)
  end

  def article_status_options
    options = [
      [t("article.status.all"), ''],
      [I18n.t("article.status.published"), true],
      [I18n.t("article.status.unpublished"), false],
    ]

    options_for_select(options)
  end

  def hot_articles
    Article.published.order(pageview: :desc, published_at: :desc).limit(8).select(%w[id title published_at])
  end
end
