FactoryGirl.define do
  factory :story do
    user
    name { Faker::Hipster.word }
    description { Faker::Lorem.paragraph }
    discoverable { [true, false].sample }
  end
end
