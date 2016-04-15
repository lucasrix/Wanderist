class Profile < ActiveRecord::Base
  ABOUT_MAX_LENGTH = 255

  belongs_to :user
  has_one :location, as: :locatable

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :about, length: { maximum: ABOUT_MAX_LENGTH }
  validates :photo,
            file_size: {
              less_than: 10.megabytes
            },
            file_content_type: {
              # allow: /^image\/.*/,
              exclude: ['image/gif']
            }

  mount_uploader :photo, ProfilePhotoUploader

  delegate :likes_count, to: :user

  def followings_count
    Following.where(user: user).count
  end

  def followers_count
    Following.where(followable: user).count
  end

  def saves_count
    StoryPoint.joins(:stories)
              .where(stories: { id: user.stories.ids })
              .where.not(user: user).count
  end

  delegate :story_points_count, to: :user
end
