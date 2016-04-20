class StoryPointSerializer < ApplicationSerializer
  include SerializerLikable
  include SerializerUtils

  attributes :id, :caption, :kind, :text, :created_at, :updated_at

  has_one :user
  has_one :location
  has_one :attachment

  has_many :tags
end
