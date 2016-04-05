require 'active_support/concern'

module SerializerFollowable
  extend ActiveSupport::Concern

  included do
    attributes :followings_count, :followed
  end

  def followed
    object.followed?(current_user)
  end
end
