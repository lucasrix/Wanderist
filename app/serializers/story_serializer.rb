class StorySerializer < ApplicationSerializer
  include SerializerLikable

  attributes :id, :name, :description, :discoverable
  has_many :story_points
end
