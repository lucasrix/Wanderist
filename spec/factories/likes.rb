FactoryGirl.define do
  factory :like do
    user
    likable { create(:story_point) }
  end
end
