class PostImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
    if original_filename
      "#{model.image}"
    end
  end
end
