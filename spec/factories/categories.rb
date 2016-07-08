FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category ##{n.next}" }
  end
end
