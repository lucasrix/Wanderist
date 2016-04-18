class ProfilePhotoUploader < ApplicationUploader
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def extension_white_list
    %w(jpg jpeg png)
  end

  version :big_thumbnail do
    process resize_to_fill: [300, 300]
  end

  version :small_thumbnail do
    process resize_to_fill: [150, 150]
  end

end
