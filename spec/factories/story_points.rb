FactoryGirl.define do
  factory :story_point do
    user
    caption { Faker::Lorem.sentence }
  end
end
