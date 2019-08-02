FactoryBot.define do
  factory :article, class: Article do
    label
    user
    title      "测试标题"
    body       "测试内容"
    body_html  '测试内容'
    pageview       10
    published_at   Time.current - 10.day
    published   true
  end
end