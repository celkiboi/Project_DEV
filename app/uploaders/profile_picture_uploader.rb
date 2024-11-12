class ProfilePictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :small do
    process resize_to_fit: [200, nil]
  end

  version :large do
    process resize_to_fit: [600, nil]
  end

  after :store, :remove_original_file

  private

  def remove_original_file(file)
    if versions[:small].present? && versions[:large].present? && File.exist?(path)
      File.delete(path)
    end
  end
end
