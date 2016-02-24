class StoryPoint < ActiveRecord::Base
  belongs_to :user
  has_many :reports, as: :reportable
  has_many :likes
  has_many :liking_users, through: :likes, source: :user
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :stories

  validates :latitude, presence: true
  validates :longitude, presence: true

  enum kind: %i(audio photo text video)
end
