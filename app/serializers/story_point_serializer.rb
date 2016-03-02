class StoryPointSerializer < ApplicationSerializer
  attributes :id, :caption, :kind

  has_one :attachment
  has_one :location
  has_many :tags
end