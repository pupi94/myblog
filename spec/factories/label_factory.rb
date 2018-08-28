FactoryBot.define do
  factory :label, class: Label do
    sequence(:name)       {|n| "Label#{n}"}
    enabled  true
  end
end
