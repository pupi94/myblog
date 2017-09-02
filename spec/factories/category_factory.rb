FactoryGirl.define do
  factory :category, class: Category do
    sequence(:name)       {|n| "类别#{n}"}
    sequence(:seq)        { |n| n }

    factory :category_with_article do
      after(:create) do |category|
        create(:article, category_id: category.id)
        create(:article, category_id: category.id)
        create(:article, category_id: category.id)
      end
    end
  end
end
