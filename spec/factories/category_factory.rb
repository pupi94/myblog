FactoryGirl.define do
  factory :category, class: Category do
    sequence(:name)       {|n| "类别#{n}"}
    sequence(:seq)          { |n| n }
    created_at                  Time.now
    updated_at                 Time.now
  end
end
