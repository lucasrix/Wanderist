class Story < ActiveRecord::Base
  belongs_to :user
  has_many :story_points
  has_many :reports, as: :reportable

  validates :name, presence: true
end
