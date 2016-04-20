class StorySerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerFollowable
  include SerializerUtils

  attributes :id, :name, :description, :discoverable, :created_at, :updated_at
  has_many :story_points
  has_one :user
end
