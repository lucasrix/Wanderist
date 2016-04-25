class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User
  include Followable
  delegate :count, to: :likes, prefix: 'likes'
  delegate :count, to: :story_points, prefix: 'story_points'
  delegate :count, to: :stories, prefix: 'stories'

  has_one :profile, dependent: :destroy
  has_many :stories
  has_many :story_points
  has_many :likes
  has_many :followers , through: :followings, source: :user

  def followed
    User.joins(:followings).where('followings.user_id = ?', id)
  end

  validate :unique_email_user, if: Proc.new { |u| u.provider == 'email' && u.email_change }
   #validates :email,
             # presence: true,
             #uniqueness: {
               #case_sensitive: false
             #}

  after_create do
    Profile.create(user: self)
  end
end

