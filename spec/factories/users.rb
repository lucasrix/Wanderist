FactoryGirl.define do
  factory :user do
    provider 'email'
    uid { Faker::Internet.email }
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { Faker::Internet.password }
    username { Faker::Internet.user_name }

    after(:create) do |user, _evaluator|
      attributes = attributes_for(:profile)
      user.profile.update_attributes(attributes)
    end
  end
end
