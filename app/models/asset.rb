class Asset < ActiveRecord::Base
  mount_uploader :file, AssetsUploader

  belongs_to :user

  def image?
    ['.jpeg', '.jpg', '.png', '.gif'].include? File.extname(file_url)
  end

  def filename
    File.basename(file_url)
  end

  def doruby?
    original_filename.present?
  end
end
