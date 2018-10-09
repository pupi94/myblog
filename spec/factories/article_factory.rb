FactoryBot.define do
  factory :article, class: Article do
    label
    user
    title      "测试标题"
    summary    "摘要"
    body       "测试内容"
    body_html  '测试内容'
    pv          10
    pubdate     Time.current - 10.day
    status      "opened"
    enabled     true
  end
end