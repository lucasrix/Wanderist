FactoryGirl.define do
  factory :story_point do
    user
    caption { Faker::Hipster.word }
    text { Faker::Hipster.paragraph }
    location
    kind :text

    factory :story_point_with_attachment do
      kind :photo
      attachment
    end

    trait :with_tags do
      after(:create) do |story_point|
        story_point.tags << create_list(:tag, 2)
      end
    end
  end
end
