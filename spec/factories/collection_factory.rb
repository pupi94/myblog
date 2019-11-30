# frozen_string_literal: true

FactoryBot.define do
  factory :collection, class: Collection do
    user
    name     { "name" }
    description { "test description" }
  end
end
