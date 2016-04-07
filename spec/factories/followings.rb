FactoryGirl.define do
  factory :following do
    user
    association :followable
  end
end
