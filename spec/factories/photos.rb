FactoryGirl.define do
  factory :photo do
    file { Faker::Lorem.sentence }
  end
end
