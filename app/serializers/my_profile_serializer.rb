class MyProfileSerializer < ProfileSerializer
  self.root = :profile
  attributes :followers_count, :followings_count
end
