FactoryBot.define do
  factory :category, class: Category do
    sequence(:name)       {|n| "类别#{n}"}
    sequence(:seq)        {|n| n}
    enabled  true
  end
end
