module LikableSerializer
  extend ActiveSupport::Concern

  included do
    attributes :likes_count, :liked
  end

  def liked
    object.liked?(current_user)
  end
end
