class Attachment < ActiveRecord::Base
  belongs_to :user

  mount_uploader :file, FileUploader

  validates :file, presence: true, file_size: { less_than: 100.megabytes }
  validates :user, presence: true
end
