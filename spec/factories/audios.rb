FactoryGirl.define do
  factory :audio do
    file { Faker::Lorem.sentence }
  end
end
