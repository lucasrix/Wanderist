class MyProfileSerializer < ProfileSerializer
  attributes :followers_count, :following_count, :likes_count, :saves_count

  def followers_count
    0
  end

  def following_count
    0
  end

  def likes_count
    0
  end

  def saves_count
    0
  end
end
