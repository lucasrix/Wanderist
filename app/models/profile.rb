class Profile < ActiveRecord::Base
  ABOUT_MAX_LENGTH = 255

  belongs_to :user

  # validates :first_name, presence: true
  # validates :last_name, presence: true
  validates :about, length: { maximum: ABOUT_MAX_LENGTH }
  validates :photo,
            file_size: {
              less_than: 10.megabytes
            },
            file_content_type: {
              #allow: /^image\/.*/,
              exclude: ['image/gif']
            }

  mount_uploader :photo, ProfilePhotoUploader

  def likes_count
    user.likes_count
  end

  def followings_count
    Following.where(user: user).count
  end

  def followers_count
    Following.where(followable: user).count
  end

  def saves_count
    StoryPoint.joins(:stories)
              .where(stories: {id: user.stories.ids})
              .where.not(user: user).count
  end

  def story_points_count
    user.story_points_count
  end
end
