# frozen_string_literal: true

FactoryBot.define do
  factory :article, class: Article do
    user
    title     { "测试标题" }
    content      { "测试内容" }
    html_content  { "测试内容" }
    pageview      { 10 }
    published_at   { Time.current - 10.days }
    published { true }
  end
end
