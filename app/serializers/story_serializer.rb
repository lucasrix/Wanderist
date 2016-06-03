class StorySerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerFollowable
  include SerializerReportable
  include SerializerUtils

  attributes :id, :name, :description, :discoverable, :created_at, :updated_at
  has_many :story_points
  has_one :user

  def story_points
    object.story_points_readable(current_user)
  end
end
