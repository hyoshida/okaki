class Tracker < ActiveRecord::Base
  extend Enumerize

  validates :name, presence: true, length: { maximum: 255 }
  validates :tracker_id, length: { maximum: 255 }
  validates :code, presence: true
  validates :location, presence: true

  scope :active, -> { where(active: true) }
  scope :by_newest, -> { reorder(created_at: :desc) }

  enumerize :location, in: %i(
    after_opening_body
    before_closing_body
    head
  ), scope: true
end
