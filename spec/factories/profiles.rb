FactoryGirl.define do
  factory :profile do
    user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    city { Faker::Address.city }
    url { Faker::Internet.url }
    about { Faker::Hipster.sentence }
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.jpg')) }
  end
end
