class Attachment < ActiveRecord::Base
  belongs_to :user

  mount_uploader :file, FileUploader

  validates :file, presence: true

end
