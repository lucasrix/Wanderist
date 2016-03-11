FactoryGirl.define do
  factory :story do
    user
    name { Faker::Hipster.word }
    description { Faker::Lorem.paragraph }
    discoverable { [true, false].sample }

    factory :story_with_story_points do
      after(:create) do |story, _evaluator|
        story.story_points = create_list(:story_point, 3)
      end
    end
  end
end
