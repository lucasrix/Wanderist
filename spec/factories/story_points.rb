FactoryGirl.define do
  factory :story_point do
    user
    caption { Faker::Lorem.sentence }
    location { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    public false
  end
end
