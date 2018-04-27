FactoryBot.define do
  factory :category, class: Category do
    sequence(:name)       {|n| "类别#{n}"}
    sequence(:name_en)    {|n| "leibie#{n}"}
    sequence(:seq)        {|n| n}
    enabled  true
  end
end
