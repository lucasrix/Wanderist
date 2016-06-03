class Story < ActiveRecord::Base
  include Likable
  include Followable
  include Pushable
  include Reportable
  include Notificable

  NAME_MAX_LENGTH = 25
  DESCRIPTION_MAX_LENGTH = 1500

  delegate :readable, to: :story_points, prefix: 'story_points'

  belongs_to :user
  has_many :notifications, as: :notificable

  has_and_belongs_to_many :story_points, after_add: [:initialize_push_notifications, :initialize_notifications]

  validates :user, presence: true
  validates :name,
            presence: true,
            length: {
              maximum: NAME_MAX_LENGTH
            }
  validates :description,
            length: {
              maximum: DESCRIPTION_MAX_LENGTH
            }
  validates :discoverable, inclusion: { in: [true, false] }
end
