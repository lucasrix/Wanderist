class Story < ActiveRecord::Base
  belongs_to :user
  has_many :reports, as: :reportable
  has_many :story_relationships
  has_many :followers, through: :story_relationships, source: :user
  has_and_belongs_to_many :story_points

  validates :name, presence: true
end
