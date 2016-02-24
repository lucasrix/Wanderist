FactoryGirl.define do
  factory :story do
    user
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    public false
  end
end
