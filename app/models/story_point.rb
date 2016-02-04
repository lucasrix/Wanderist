class StoryPoint < ActiveRecord::Base
  belongs_to :user
  has_many :reports, as: :reportable
  has_and_belongs_to_many :tags
  has_and_belongs_to_many :stories

  validates :latitude, presence: true
  validates :longitude, presence: true

  enum type: %i(audio image photo text)
end
