class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_points
  has_many :reports, as: :reportable
  has_and_belongs_to_many :story_points

  validates :name, presence: true
end
