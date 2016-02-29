class StoryPoint < ActiveRecord::Base
  belongs_to :user
  belongs_to :story

  validates :caption, presence: true
  validates :user_id, presence: true
end
