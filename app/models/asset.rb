class Asset < ActiveRecord::Base
  mount_uploader :file, AssetsUploader

  belongs_to :user

  before_save :set_title

  def image?
    ['.jpeg', '.jpg', '.png', '.gif'].include? File.extname(file_url)
  end

  def filename
    File.basename(file_url)
  end

  def file_size
    file.size
  end

  # one convenient method to pass jq_upload the necessary information
  # from: https://github.com/tors/jquery-fileupload-rails/wiki
  def to_jquery_upload
    {
      name: read_attribute(:file),
      size: file.size,
      url: file.url
    }
  end

  def doruby?
    original_filename.present?
  end

  private

  def set_title
    return unless file
    return unless file_changed?
    filename = file.send(:original_filename)
    self.title ||= File.basename(filename, '.*')
  end
end
