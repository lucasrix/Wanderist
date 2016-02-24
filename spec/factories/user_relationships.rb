FactoryGirl.define do
  factory :user_relationship do
    follower { create(:user) }
    followed { create(:user) }
  end
end
