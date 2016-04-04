module Likable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable

    delegate :count, to: :likes, prefix: 'likes'
  end

  def liked?(user)
    likes.exists?(user: user)
  end
end
