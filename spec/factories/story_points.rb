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
  end
end
