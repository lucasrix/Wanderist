class StoryPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  has_one :content
  has_many :reports, as: :reportable
  has_and_belongs_to_many :tags

  validates :latitude, presence: true
  validates :longitude, presence: true
end
