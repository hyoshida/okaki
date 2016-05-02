FactoryGirl.define do
  factory :entry do
    user
    sequence(:title) { |n| "Entry ##{n.next}" }
    body 'body'
  end
end
