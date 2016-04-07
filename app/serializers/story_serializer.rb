class StorySerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerFollowable

  attributes :id, :name, :description, :discoverable
  has_many :story_points
end
