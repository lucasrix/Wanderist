module Followable
  extend ActiveSupport::Concern

  included do
    has_many :followings, as: :followable
    has_many :followers, through: :followings, source: :user

    delegate :count, to: :followings, prefix: 'followings'
  end

  def followed?(user)
    followings.exists?(user: user)
  end
end
