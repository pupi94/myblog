# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "superadmin#{n}@ping.com"
  end

  factory :user, class: User do
    username "superadmin"
    email { generate(:email) }
    password "123456"
  end
end
