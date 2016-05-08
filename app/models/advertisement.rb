class Advertisement < ActiveRecord::Base
  mount_uploader :image, AdvertisementImageUploader

  validates :title, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image, presence: true

  def title
    read_attribute(:title) || 'No Title'
  end
end