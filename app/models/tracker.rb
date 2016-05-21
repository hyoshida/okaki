class Tracker < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 255 }
  validates :tracker_id, length: { maximum: 255 }
  validates :code, presence: true

  scope :active, -> { where(active: true) }
  scope :by_newest, -> { reorder(created_at: :desc) }
end
