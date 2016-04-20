require 'streamio-ffmpeg'

class FileUploader < ApplicationUploader

  def extension_whitelist
    %w(jpg jpeg gif png wav mp3 mp4)
  end

  def content_type_whitelist
    /image\//
  end

  version :thumbnail, if: :is_image? do
    process resize_to_fill: [200, 200]
  end

  #version :video_thumbnail, if: :is_video? do
    #process :screenshot
    #def full_filename(for_file)
      #%(thumbnail_#{File.basename(for_file, '.*')}.jpg)
    #end
  #end

  protected

  def screenshot
    movie = FFMPEG::Movie.new(current_path)
    movie.screenshot(current_path + '.jpg', { resolution: '200x200' }, preserve_aspect_ratio: :width)
    File.rename(current_path + '.jpg', current_path)
  end

  def is_image?(_attachment)
    content_type(original_filename).match(/image\/jpeg|image\/gif|image\/png|image\/jpg/i)
  end

  def is_video?(_attachment)
    content_type(original_filename).match(/video\/mp4|video\/wav|video\/mov|video/i)
  end

  def content_type(file)
    MIME::Types.type_for(file).first.content_type
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
