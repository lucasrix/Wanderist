FactoryGirl.define do
  factory :story_point do
    user
    caption { Faker::Lorem.sentence }
    location
    kind { StoryPoint::KINDS.sample }
  end
end
