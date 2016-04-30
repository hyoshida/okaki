FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user+#{n.next}" }
    sequence(:email) { |n| "#{name}@example.com" }
    password 'password'
  end
end
