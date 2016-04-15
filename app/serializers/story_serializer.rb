class StorySerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerFollowable
  include SerializerUtils

  attributes :id, :name, :description, :discoverable
  has_many :story_points
  has_one :user
end
