class StorySerializer < ApplicationSerializer
  attributes :id, :name, :description, :discoverable
  has_many :story_points
end
