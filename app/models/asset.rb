class Asset < ActiveRecord::Base
  mount_uploader :file, AssetUploader

  belongs_to :user
end
