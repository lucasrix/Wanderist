class StoryPointSerializer < ApplicationSerializer
  attributes :id, :caption, :kind

  has_one :location
  has_many :tags
end