# frozen_string_literal: true

FactoryBot.define do
  factory :collection_article, class: CollectionArticle do
    article
    collection
  end
end
