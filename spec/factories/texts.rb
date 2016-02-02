FactoryGirl.define do
  factory :text do
    file { Faker::Lorem.sentence }
  end
end
