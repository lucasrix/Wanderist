class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User
  include Followable
  delegate :count, to: :likes, prefix: 'likes'
  delegate :count, to: :story_points, prefix: 'story_points'

  has_one :profile, dependent: :destroy
  has_many :stories
  has_many :story_points
  has_many :likes
  has_many :followers , through: :followings, source: :user

  def followed
    User.joins(:followings).where('followings.user_id = ?', id)
  end
  # validates :username,
  #           # presence: true,
  #           uniqueness: {
  #             case_sensitive: false
  #           }

  after_create do
    Profile.create(user: self)
  end
end

