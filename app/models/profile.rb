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
end
