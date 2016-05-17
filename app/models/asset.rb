class Asset < ActiveRecord::Base
  mount_uploader :file, AssetsUploader

  belongs_to :user
end
