class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :profile
  has_many :stories
  has_many :story_points
  has_many :story_relationships
  has_many :followed_stories, through: :story_relationships, source: :story
  has_many :active_relationships, class_name: UserRelationship.name,
                                  foreign_key: 'follower_id'
  has_many :passive_relationships, class_name: UserRelationship.name,
                                  foreign_key: 'followed_id'
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes
  has_many :liked_story_points, through: :likes, source: :story_point

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  after_create do
    Profile.create(user: self)
  end
end
