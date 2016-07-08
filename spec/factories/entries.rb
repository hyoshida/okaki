FactoryGirl.define do
  factory :entry do
    user
    sequence(:title) { |n| "Entry ##{n.next}" }
    body 'body'
    image Rack::Test::UploadedFile.new(Rails.root.join('public/favicon.ico'))
    category
  end
end
