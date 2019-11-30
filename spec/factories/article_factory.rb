# frozen_string_literal: true

FactoryBot.define do
  factory :article, class: Article do
    user
    title     { "test title" }
    content      { "test content" }
    html_content  { "html content" }
    pageview      { 10 }
    published_at   { Time.current - 10.days }
    published { true }
  end
end
