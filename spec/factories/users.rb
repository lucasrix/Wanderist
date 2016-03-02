FactoryGirl.define do
  factory :user do
    provider 'email'
    uid { Faker::Internet.email }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
    username { Faker::Internet.user_name }

    after(:create) do |user, _evaluator|
      create(:profile, user: user)
    end
  end
end
