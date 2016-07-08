FactoryGirl.define do
  factory :page do
    sequence(:title) { |n| "Page ##{n.next}" }
    content 'Hello world!'
  end
end
