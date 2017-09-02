FactoryGirl.define do
  factory :tag, class: Tag do
    sequence(:name)       {|n| "标签#{n}"}
    enabled                true
    created_at             Time.now
    updated_at             Time.now
  end
end
