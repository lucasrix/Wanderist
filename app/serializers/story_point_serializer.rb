class StoryPointSerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerUtils

  attributes :id, :caption, :kind, :text

  has_one :user
  has_one :location
  has_one :attachment

  has_many :tags
end
