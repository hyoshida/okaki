FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user+#{n.next}@example.com" }
    password 'password'
  end
end
