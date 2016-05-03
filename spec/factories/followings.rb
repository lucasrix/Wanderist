FactoryGirl.define do
  factory :following do
    user
    followable { create(:story) }
  end
end
