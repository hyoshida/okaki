FactoryGirl.define do
  factory :tracker do
    sequence(:name) { |n| "Tracker ##{n.next}" }
    code '<!-- sample code -->'
    location 'head'
  end
end
