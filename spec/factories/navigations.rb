FactoryGirl.define do
  factory :navigation do
    sequence(:name) { |n| "Navigation ##{n.next}" }
    sequence(:url) { |n| "http://example.com/#{n.next}" }
    location 'header'
  end
end
