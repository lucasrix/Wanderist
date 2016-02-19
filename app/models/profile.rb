class Profile < ActiveRecord::Base
  ABOUT_MAX_LENGTH = 255

  belongs_to :user

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :about, length: { maximum: ABOUT_MAX_LENGTH }

  mount_uploader :photo, ProfilePhotoUploader
end
