FactoryGirl.define do
  factory :report do
    user
    story_point
    kind { Faker::Lorem.word }
    message { Faker::Lorem.paragraph }
  end
end
