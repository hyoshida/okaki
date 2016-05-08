class Advertisement < ActiveRecord::Base
  validates :title, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image, presence: true, length: { maximum: 255 }

  def title
    read_attribute(:title) || 'No Title'
  end
end
