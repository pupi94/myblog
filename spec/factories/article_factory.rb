FactoryGirl.define do
  factory :articles, class: Article do
    title         "测试标题"
    source        "文章来源"
    source_url    "https://www.google.com"
    source_type   SourceType::ORIGINA
    category_id   1
    tags          "1,2"
    summary       "摘要"
    content       "测试内容"
    attachment    ""
    author_id     1
    author_name   "测试用户"
    pv            10
    pubdate       Time.now - 10.day
    status        ArticleStatus::PUBLISHED
    enabled       true
  end
end
