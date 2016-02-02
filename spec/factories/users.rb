FactoryGirl.define do
  factory :user do
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }
    email { Faker::Internet.email }
    provider 'email'
    uid { email }

    after(:create) do |user|
      create(:settings_suit, user: user)
    end
  end
end
