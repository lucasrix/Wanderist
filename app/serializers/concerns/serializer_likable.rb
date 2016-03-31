require 'active_support/concern'

module SerializerLikable
  extend ActiveSupport::Concern

  included do
    attributes :likes_count, :liked
  end

  def liked
    object.liked?(scope)
  end
end
