FactoryGirl.define do
  factory :notification do
    user
    unread true
    association :notificable
    message { Faker::Lorem.paragraph }
  end
end
