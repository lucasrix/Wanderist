require 'active_support/concern'

module SerializerFollowable
  extend ActiveSupport::Concern

  included do
    attributes :followings_count, :followed, :follower
  end

  def followed
    object.followed?(current_user)
  end

  def filter(keys)
    if current_user && object.is_a?(User)
      keys
    else
      keys - [:follower]
    end
  end

  def follower
    current_user.followed?(object)
  end
end
