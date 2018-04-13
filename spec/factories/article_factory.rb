FactoryBot.define do
  factory :articles, class: Article do
    category
    author_id     1
    author_name   "测试用户"
    title         "测试标题"
    source        "文章来源"
    source_url    "https://www.google.com"
    source_type   SourceType::ORIGINA
    tags          "1,2"
    summary       "摘要"
    content       "测试内容"
    content_html  '测试内容'
    pv            10
    pubdate       Time.now - 10.day
    status        ArticleStatus::PUBLISHED
    enabled       true
  end
end