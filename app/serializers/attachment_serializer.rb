class AttachmentSerializer < ApplicationSerializer
  attributes :id, :file_url, :thumbnail

  def thumbnail
    if object.present?
      object.file_url(:thumbnail)# || object.file_url(:video_thumbnail)
    end
  end
end
