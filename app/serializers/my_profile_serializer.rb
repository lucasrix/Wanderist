class MyProfileSerializer < ProfileSerializer
  attributes :followers_count, :followings_count, :likes_count, :saves_count
end
