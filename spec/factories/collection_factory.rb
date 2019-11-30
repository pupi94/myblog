# frozen_string_literal: true

FactoryBot.define do
  factory :collection, class: Collection do
    user
    title     { "test title" }
    description { "test description" }
  end
end
