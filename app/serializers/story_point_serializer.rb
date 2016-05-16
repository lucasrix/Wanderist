class StoryPointSerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerReportable
  include SerializerUtils

  attributes :id, :caption, :kind, :text, :created_at, :updated_at

  has_many :stories, serializer: StoryLinkSerializer, root: :story_links
  has_one :user
  has_one :location
  has_one :attachment

  has_many :tags
end
