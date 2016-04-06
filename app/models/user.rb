class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User
  include Followable

  has_one :profile, dependent: :destroy
  has_many :stories
  has_many :story_points
  has_many :likes

  # validates :username,
  #           # presence: true,
  #           uniqueness: {
  #             case_sensitive: false
  #           }

  after_create do
    Profile.create(user: self)
  end
end
