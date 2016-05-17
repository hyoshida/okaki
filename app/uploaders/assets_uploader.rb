class AssetsUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}"
  end
end
