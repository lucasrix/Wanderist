class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_one :settings_suit
  has_many :stories
  has_many :story_points

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
