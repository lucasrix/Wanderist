class Tag < ActiveRecord::Base
  has_and_belongs_to_many :story_points

  validates :name, presence: true
end
