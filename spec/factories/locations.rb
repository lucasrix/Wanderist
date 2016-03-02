FactoryGirl.define do
  factory :location do
    latitude { Faker::Number.decimal(2) }
    longitude { Faker::Number.decimal(2) }
  end
end
