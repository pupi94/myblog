FactoryBot.define do
  factory :user, class: User do
    username  'hpp'
    password  '12345678'
    nickname  'hpp'
    enabled   true
  end
end
