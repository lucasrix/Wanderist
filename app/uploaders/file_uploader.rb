class FileUploader < ApplicationUploader

  def extension_whitelist
    %w(jpg jpeg gif png wav mp3 mp4)
  end

  def content_type_whitelist
    /image\//
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
