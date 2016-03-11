class StoryPointSerializer < ApplicationSerializer
  attributes :id, :caption, :kind

  has_one :user
  has_one :location
  has_one :attachment

  has_many :tags
end