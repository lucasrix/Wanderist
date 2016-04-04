class StorySerializer < ApplicationSerializer
  include LikableSerializer

  attributes :id, :name, :description, :discoverable
  has_many :story_points
end
