FactoryGirl.define do
  factory :asset do
    user
    file Rack::Test::UploadedFile.new(Rails.root.join('public/favicon.ico'))
  end
end
