class Profile < ActiveRecord::Base
  ABOUT_MAX_LENGTH = 1500

  belongs_to :user
  has_one :location, as: :locatable

  validates :about, length: { maximum: ABOUT_MAX_LENGTH }
  validates :photo,
            file_size: {
              less_than: 10.megabytes
            },
            file_content_type: {
              exclude: ['image/gif']
            }

  mount_uploader :photo, ProfilePhotoUploader

  delegate :likes_count, to: :user
  delegate :story_points_count, to: :user
  delegate :stories_count, to: :user

  after_create do
    create_location(Location::DEFAULT_CITY_PARAMS)
  end

  def likes_count
    Like.where(likables_query, user.stories.select(:id), user.story_points.select(:id)).count
  end

  def likables_query
    "likable_type='Story' and likable_id in (?) or likable_type='StoryPoint' and likable_id in (?)"
  end

  def followings_count
    Following.where(user: user).count
  end

  def followers_count
    Following.where(followable: user).count
  end

  def saves_count
    StoryPoint.joins(:stories)
              .where.not(stories: { id: user.stories.ids })
              .where(user: user).count
  end
end
