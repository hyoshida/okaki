class AssetsUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore.pluralize}/#{model.id}"
  end

  # Use file`s MD5 as filename
  # from https://github.com/carrierwaveuploader/carrierwave/wiki/How-to:-Use-file%60s-MD5-as-filename
  def md5
    @md5 ||= Digest::MD5.hexdigest model.send(mounted_as).read.to_s
  end

  def filename
    @name ||= "#{md5}#{File.extname(super).downcase}" if super
  end
end
