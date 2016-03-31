FactoryGirl.define do
  factory :like do
    user
    association :likable
  end
end
