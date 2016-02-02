FactoryGirl.define do
  factory :story do
    user
    reports
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    public false
  end
end
