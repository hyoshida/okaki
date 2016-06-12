class Advertisement < ActiveRecord::Base
  mount_uploader :image, AssetsUploader

  acts_as_list

  validates :title, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image, presence: true

  default_scope -> { order(:position) }

  def title
    read_attribute(:title) || 'No Title'
  end
end
