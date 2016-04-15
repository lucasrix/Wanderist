FactoryGirl.define do
  factory :location do
    latitude { Faker::Number.decimal(2) }
    longitude { Faker::Number.decimal(2) }
  end

  trait :valid_location do
    latitude  50.4501
    longitude 30.5234
  end
end
