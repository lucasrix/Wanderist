FactoryGirl.define do
  factory :video do
    file { Faker::Lorem.sentence }
  end
end
