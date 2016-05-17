class Asset < ActiveRecord::Base
  mount_uploader :file, AssetsUploader

  belongs_to :user

  def doruby?
    original_filename.present?
  end
end
