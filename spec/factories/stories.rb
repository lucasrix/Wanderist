FactoryGirl.define do
  factory :story do
    user
    name { Faker::Hipster.word }
    description { Faker::Lorem.paragraph }
  end
end
